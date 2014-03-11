require 'shellwords'

class Freighthop::CLI::SSH
  def self.match?(*args)
    !args.empty? # we handle guest passthrough
  end

  def initialize(*args)
    @args = args
  end

  def run
    Freighthop::CLI::Checks.ensure_config_exists!
    if shell?
      ssh('-i')
    else
      ssh(%Q(-c "#{Shellwords.join(@args)}"))
    end
  end

  def shell?
    @args.first == 'ssh'
  end

  def ssh(cmd)
    exec %Q(ssh -q -t -F #{config} #{app_name} 'cd #{guest_root}; /bin/bash -l #{cmd}')
  end

  def config
    config_path.tap do |conf|
      if !conf.exist? || (Time.now - conf.mtime) > 86400
        File.write(conf, ssh_config)
      end
    end
  end

  def ssh_config
    <<-SSH_CONFIG.gsub(/^      /, '')
      Host #{app_name}
        HostName #{hostname}
        User vagrant
        Port 22
        UserKnownHostsFile /dev/null
        StrictHostKeyChecking no
        PasswordAuthentication no
        IdentityFile #{vagrant_ssh_key_path}
        IdentitiesOnly yes
        LogLevel FATAL
        ForwardAgent yes
    SSH_CONFIG
  end

  def vagrant_ssh_key_path
    Pathname('~/.vagrant.d/insecure_private_key').expand_path
  end

  def config_path
    Pathname("/tmp/freighthop.#{app_name}.ssh-config")
  end

  def hostname
    Freighthop.hostname
  end

  def app_name
    Freighthop.app_name
  end

  def guest_root
    Freighthop.guest_root
  end
end


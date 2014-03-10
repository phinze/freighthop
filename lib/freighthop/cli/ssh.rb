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
      ssh(%Q(-c "#{@args.join(' ')}"))
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
        `vagrant ssh-config | sed 's/HostName .*$/HostName #{Freighthop.hostname}/' > #{conf}`
      end
    end
  end

  def config_path
    Pathname("/tmp/freighthop.#{app_name}.ssh-config")
  end

  def app_name
    Freighthop.app_name
  end

  def guest_root
    Freighthop.guest_root
  end
end


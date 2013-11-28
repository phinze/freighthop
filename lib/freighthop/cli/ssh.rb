class Freighthop::CLI::SSH < Freighthop::CLI::Base
  def self.match?(*args)
    !args.empty? # we handle guest passthrough
  end

  def run(args)
    if args.first == 'ssh'
      ssh('-i')
    else
      ssh(%Q(-c "#{args.join(' ')}"))
    end
  end

  def ssh(cmd)
    exec %Q(ssh -t -F #{config} #{app_name} 'cd #{guest_root}; /bin/bash -l #{cmd}')
  end

  def config
    config_path.tap do |conf|
      if !conf.exist? || (Time.now - conf.mtime) > 3600
        `vagrant ssh-config > #{conf}`
      end
    end
  end

  def config_path
    Pathname("/tmp/freighthop.#{app_name}.ssh-config")
  end

  def app_name
    freighthop.app_name
  end

  def guest_root
    freighthop.guest_root
  end
end


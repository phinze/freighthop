require 'pathname'

require_relative 'freighthop/version'
require_relative 'freighthop/config'
require_relative 'freighthop/cli'
require_relative 'freighthop/vagrant_env'

module Freighthop
  class << self
    def vmware?
      !!(defined? HashiCorp)
    end

    def host_root
      Pathname.pwd
    end

    def guest_root
      Pathname("/srv/#{app_name}")
    end

    def freighthop_root
      Pathname(File.dirname(__FILE__)).join('..').expand_path
    end

    def app_name
      @app_name ||= host_root.basename.to_s
    end

    def hostname
      "#{app_name}.vagrant.dev"
    end

    def ip_address
      "10.20.1.#{app_name.getbyte(0)}"
    end

    def box_url
      if vmware?
        'http://files.vagrantup.com/precise64_vmware.box'
      else
        'http://files.vagrantup.com/precise64.box'
      end
    end

    def mounts
      Freighthop::Config.fetch('freighthop::mounts', []).map do |host, guest|
        [
          File.expand_path(host_root.join(host)),
          File.expand_path(guest_root.join(guest)),
        ]
      end
    end

    def cpus
      Freighthop::Config.fetch('freighthop::cpus', 2)
    end

    def ram
      Freighthop::Config.fetch('freighthop::ram', 1024)
    end
  end
end



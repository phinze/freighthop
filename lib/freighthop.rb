require 'pathname'
require_relative 'freighthop/version'
require_relative 'freighthop/config'

unless defined? Vagrant
  raise "i expect to be required from a Vagrantfile"
end

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
  end
end



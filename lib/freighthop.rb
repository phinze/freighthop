require 'pathname'
require_relative 'freighthop/version'

unless defined? Vagrant
  raise "i expect to be required from a Vagrantfile"
end

module Freighthop
  class << self
    def vmware?
      !!(defined? HashiCorp)
    end

    def host_rails_root
      @rails_root ||= begin
        Pathname.pwd.tap do |pwd|
          unless pwd.join('config', 'boot.rb').file?
            raise 'run me with a rails app as PWD, using VAGRANT_CWD to refer to my directory'
          end
        end
      end
    end

    def guest_rails_root
      "/srv/#{app_name}"
    end

    def app_name
      @app_name ||= host_rails_root.basename.to_s
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
  end
end



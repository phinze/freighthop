require 'pathname'

unless defined? Vagrant
  raise "i expect to be required from a Vagrantfile"
end

module VagrantOnRails
  class << self
    def vmware?
      !!(defined? HashiCorp)
    end

    def rails_root
      @rails_root ||= begin
        Pathname.pwd.tap do |pwd|
          puts "PWD IS #{pwd}"
          unless pwd.join('config', 'boot.rb').file?
            raise 'run me with a rails app as PWD, using VAGRANT_CWD to refer to my directory'
          end
        end
      end
    end

    def app_name
      @app_name ||= rails_root.basename.to_s
    end

    def hostname
      "#{app_name}.vagrant.dev"
    end

    def ip_address
      "10.20.1.3"
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



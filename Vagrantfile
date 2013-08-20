# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative 'lib/vagrant_on_rails'

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'precise64'
  config.vm.box_url = VagrantOnRails.box_url 
  config.landrush.enable

  config.vm.define VagrantOnRails.app_name do |node_config|
    node_config.vm.hostname = VagrantOnRails.hostname
    node_config.vm.network :private_network, ip: VagrantOnRails.ip_address

    node_config.vm.provider :vmware_fusion do |v|
      v.vmx['displayName'] = VagrantOnRails.hostname
      v.vmx['memsize']     = 1024
      v.vmx['numvcpus']    = 2
    end

    node_config.vm.provision :shell, path: 'init/bootstrap_puppet_omnibus.sh'

    puppet_options = [].tap do |options|
      options << %w[--verbose --debug] if ENV['PUPPET_VERBOSE']
    end

    node_config.vm.provision :puppet, options: puppet_options do |puppet|
      puppet.manifests_path = 'manifests'
      puppet.module_path = 'modules'
      puppet.manifest_file = 'site.pp'
    end
  end
end

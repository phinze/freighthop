# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative 'lib/vagrant_on_rails'

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'precise64'
  config.vm.box_url = VagrantOnRails.box_url 
  config.landrush.enable
  config.cache.auto_detect = true
  config.cache.enable_nfs = true

  config.vm.define VagrantOnRails.app_name do |node_config|
    node_config.vm.hostname = VagrantOnRails.hostname
    node_config.vm.network :private_network, ip: VagrantOnRails.ip_address

    node_config.vm.provider :vmware_fusion do |v|
      v.vmx['displayName'] = VagrantOnRails.hostname
      v.vmx['memsize']     = 2048
      v.vmx['numvcpus']    = 4
    end

    node_config.vm.synced_folder(
      VagrantOnRails.host_rails_root,
      VagrantOnRails.guest_rails_root,
      nfs: true
    )

    node_config.vm.provision :shell, path: 'init/bootstrap_puppet_omnibus.sh'

    node_config.vm.provision :shell do |s|
      s.path = 'init/symlinks_for_hiera.sh'
      s.args = VagrantOnRails.guest_rails_root
    end

    puppet_options = [].tap do |options|
      options << %w[--verbose --debug] if ENV['PUPPET_VERBOSE']
      options << %w[--templatedir templates]
      options << %w[--hiera_config /vagrant/hiera.yaml]
    end

    node_config.vm.provision :puppet, options: puppet_options do |puppet|
      puppet.manifests_path = 'manifests'
      puppet.module_path = 'modules'
      puppet.manifest_file = 'site.pp'
      puppet.facter = {
        'app_name' => VagrantOnRails.app_name
      }
    end
  end
end

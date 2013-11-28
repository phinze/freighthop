require 'pathname'

require_relative 'freighthop/version'
require_relative 'freighthop/config'
require_relative 'freighthop/cli'
require_relative 'freighthop/vagrant_env'

class Freighthop
  attr_reader :host_root

  def initialize(host_root = Pathname.pwd)
    @host_root = Pathname(host_root)
  end

  def configure_vagrantfile(config)
    config.vm.box     = box
    config.vm.box_url = box_url

    config.landrush.enable

    config.cache.auto_detect = true
    config.cache.enable_nfs  = nfs?

    config.vm.define app_name do |node_config|
      node_config.vm.hostname = hostname

      node_config.vm.provider :vmware_fusion do |v|
        v.vmx['displayName'] = hostname
        v.vmx['memsize']     = ram
        v.vmx['numvcpus']    = cpus
      end

      node_config.vm.provider :virtualbox do |v|
        v.customize ['modifyvm', :id, '--memory', ram]
        v.customize ['modifyvm', :id, '--cpus', cpus]
      end

      mounts.each do |host, guest|
        node_config.vm.synced_folder(host, guest, nfs: nfs?)
      end

      node_config.vm.provision :shell, path: 'init/bootstrap_puppet_omnibus.sh'

      node_config.vm.provision :shell do |s|
        s.path = 'init/symlinks_for_hiera.sh'
        s.args = guest_root.to_s
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
          'app_name' => app_name
        }
      end
    end
  end

  def vmware?
    !!(defined? HashiCorp)
  end

  def guest_root
    Pathname("/srv/#{app_name}")
  end

  def freighthop_root
    Pathname(File.dirname(__FILE__)).join('..').expand_path
  end

  def app_name
    @app_name ||= host_root.basename.to_s.gsub(/[_ ]/, '-')
  end

  def hostname
    "#{app_name}.vagrant.dev"
  end

  # For now only use NFS on vmware to work around this issue:
  # https://github.com/phinze/landrush/issues/17
  def nfs?
    if ENV.key? 'FREIGHTHOP_NFS'
      ['1','true','on'].include?(ENV['FREIGHTHOP_NFS'])
    else
      vmware?
    end
  end

  def box
    'precise64'
  end

  def box_url
    if vmware?
      'http://files.vagrantup.com/precise64_vmware.box'
    else
      'http://files.vagrantup.com/precise64.box'
    end
  end

  def config
    @config ||= Freighthop::Config.new(self)
  end

  def mounts
    config.fetch('freighthop::mounts', []).map do |host, guest|
      [
        File.expand_path(host_root.join(host)),
        File.expand_path(guest_root.join(guest)),
      ]
    end + [host_root, guest_root]
  end

  def cpus
    config.fetch('freighthop::cpus', 2)
  end

  def ram
    config.fetch('freighthop::ram', 1024)
  end
end



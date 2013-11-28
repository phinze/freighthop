require 'test_helper'

describe Freighthop do
  describe 'configure_vagrantfile' do
    let(:config) {
      config_map = Vagrant.plugin("2").manager.config
      Vagrant::Config::V2::Root.new(config_map)
    }

    before do
      fh = Freighthop.new
      fh.configure_vagrantfile(config)
    end

    it 'sets the box and box_url properly' do
      config.vm.box.must_equal 'precise64'
      config.vm.box_url.must_equal 'http://files.vagrantup.com/precise64.box'
    end

    it 'enables landrush' do
    end
  end

  describe 'hostname' do
    it 'returns a hostname based on the dirname of the project path' do
      fh = Freighthop.new('/path/to/myproject')
      fh.hostname.must_equal 'myproject.vagrant.dev'
    end

    it 'converts underscores and spaces into hyphens so the hostname will be valid' do
      fh = Freighthop.new('/path/to/a crazy_dirname')
      fh.hostname.must_equal 'a-crazy-dirname.vagrant.dev'
    end
  end
end

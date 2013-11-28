# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative 'lib/freighthop'

Vagrant.require_plugin 'landrush'
Vagrant.require_plugin 'vagrant-cachier'

Vagrant.configure('2') do |config|
  freighthop = Freighthop.new
  freighthop.configure_vagrantfile(config)
end

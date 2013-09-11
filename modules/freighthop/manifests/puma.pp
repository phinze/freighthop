class freighthop::puma(
  $app_root,
  $socket_path,
) {
  package { 'puma':
    ensure   => 'installed',
    provider => 'gem'
  }
  file { '/etc/init/puma.conf':
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    content => template('freighthop/puma/upstart/puma.conf.erb')
  }
  file { '/etc/puma.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "${app_root}\n"
  }
  file { '/etc/init/puma-manager.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/freighthop/puma/upstart/puma-manager.conf',
    require => [
      File['/etc/init/puma.conf'],
      File['/etc/puma.conf'],
    ],
    notify  => Service['puma-manager']
  }
  service { 'puma-manager':
    ensure   => 'running',
    provider => 'upstart'
  }
}

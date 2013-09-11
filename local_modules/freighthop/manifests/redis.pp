class freighthop::redis {
  package { 'redis-server':
    ensure => installed
  }
  service { 'redis-server':
    ensure  => running,
    require => Package['redis-server']
  }
}

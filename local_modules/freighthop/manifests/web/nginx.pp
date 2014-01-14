class freighthop::web::nginx(
  $ssl,
  $ssl_cert_path,
  $ssl_key_path,
  $server_name,
  $port          = $freighthop::params::http_port,
  $ssl_port      = $freighthop::params::https_port,
  $upstream_port = $freighthop::params::upstream_port,
  $web_root      = $freighthop::params::web_root,
) {
  class {'::nginx':
    confd_purge => true
  }

  file { '/etc/nginx/conf.d/vagrant-rails.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('freighthop/nginx/vagrant-rails.conf.erb'),
    notify  => Service['nginx'],
  }
}

class freighthop::web::apache(
  $ssl,
  $ssl_cert_path,
  $ssl_key_path,
  $server_name,
  $passenger_app_env,
  $passenger_buffer_upload,
  $port                    = $freighthop::params::http_port,
  $ssl_port                = $freighthop::params::https_port,
  $upstream_port           = $freighthop::params::upstream_port,
  $owner                   = $freighthop::params::uid,
  $group                   = $freighthop::params::gid,
  $web_root                = $freighthop::params::web_root,
  $passenger               = $freighthop::params::passenger,
) {
  class { '::apache':
    default_vhost => false,
  }
  apache::vhost { "${server_name} non-ssl":
    servername    => $server_name,
    docroot       => $web_root,
    port          => $port,
    docroot_owner => $owner,
    docroot_group => $group,
  }

  if str2bool($ssl) {
    apache::vhost { "${server_name} ssl":
      servername => $server_name,
      docroot    => $web_root,
      port       => $ssl_port,
      ssl        => true,
      ssl_cert   => $ssl_cert_path,
      ssl_key    => $ssl_key_path,
    }
  }

  if str2bool($passenger) {
    package { 'apt-transport-https':
      ensure => installed
    } ->
    apt::source { 'phusion':
      location => 'https://oss-binaries.phusionpassenger.com/apt/passenger',
      key      => '561F9B9CAC40B2F7',
      pin      => 1000,
    } ->
    package { 'passenger':
      ensure => 'installed'
    } ->
    apache::mod { 'passenger':
    } ->
    file { '/etc/apache2/conf.d/passenger.conf':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('freighthop/apache/passenger.conf.erb'),
      notify  => Service['httpd'],
    }
  }
}

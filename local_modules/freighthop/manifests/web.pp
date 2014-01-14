class freighthop::web(
  $servers       = $freighthop::params::web_servers,
  $server_name   = $freighthop::params::server_name,
  $ssl           = $freighthop::params::ssl,
  $ssl_cert_path = $freighthop::params::ssl_cert_path,
  $ssl_key_path  = $freighthop::params::ssl_key_path,
) {
  if $ssl {
    class { 'freighthop::web::ssl':
      ssl_cert_path => $ssl_cert_path,
      ssl_key_path  => $ssl_key_path,
      server_name   => $server_name,
    }
  }

  if member($servers, 'nginx') {
    class { 'freighthop::web::nginx':
      ssl           => $ssl,
      ssl_cert_path => $ssl_cert_path,
      ssl_key_path  => $ssl_key_path,
      server_name   => $server_name,
    }
  }
  if member($servers, 'apache') {
    class { 'freighthop::web::apache':
      ssl           => $ssl,
      ssl_cert_path => $ssl_cert_path,
      ssl_key_path  => $ssl_key_path,
      server_name   => $server_name,
    }
  }
}

class freighthop(
  $databases,
  $database_users,
  $packages        = $freighthop::params::packages,
  $ppas            = $freighthop::params::ppas,
  $ruby_version    = $freighthop::params::ruby_version,
  $app_name        = $freighthop::params::app_name,
  $app_root        = $freighthop::params::app_root,
  $web_root        = $freighthop::params::web_root,
  $web_port        = $freighthop::params::web_port,
  $server_name     = $freighthop::params::server_name,
  $ssl_cert_path   = $freighthop::params::ssl_cert_path,
  $ssl_key_path    = $freighthop::params::ssl_key_path,
) inherits freighthop::params {
  include apt

  class { 'freighthop::ppas':
    ppas => $ppas,
  } ->
  class { 'freighthop::pkgs':
    packages => $packages,
  } ->
  class { 'freighthop::rbenv':
    ruby_version => $ruby_version
  } ->
  class { 'freighthop::nginx':
    upstream_web_port  => $web_port,
    server_name        => $server_name,
    web_root           => $web_root,
    ssl_cert_path      => $ssl_cert_path,
    ssl_key_path       => $ssl_key_path,
  } ->
  class { 'freighthop::postgres':
    databases      => $databases,
    database_users => $database_users,
  } ->
  class { 'freighthop::bundler':
    ruby_version => $ruby_version,
    app_root     => $app_root,
  }
}

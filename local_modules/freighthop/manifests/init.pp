class freighthop(
  $ppas             = $freighthop::params::ppas,
  $packages         = $freighthop::params::packages,
  $languages        = $freighthop::params::languages,
  $ruby_version     = $freighthop::params::ruby_version,
  $app_name         = $freighthop::params::app_name,
  $app_root         = $freighthop::params::app_root,
  $web_root         = $freighthop::params::web_root,
  $web_port         = $freighthop::params::web_port,
  $server_name      = $freighthop::params::server_name,
  $ssl_cert_path    = $freighthop::params::ssl_cert_path,
  $ssl_key_path     = $freighthop::params::ssl_key_path,
) inherits freighthop::params {

  class { 'freighthop::packages':
    ppas      => $ppas,
    packages  => $packages,
    languages => $languages,
  } ->

  class { 'freighthop::language':
    languages    => $languages,
    ruby_version => $ruby_version
  } ->

  class { 'freighthop::web':
    upstream_web_port => $web_port,
    server_name       => $server_name,
    web_root          => $web_root,
    ssl_cert_path     => $ssl_cert_path,
    ssl_key_path      => $ssl_key_path,
  } ->

  class { 'freighthop::database':}
}

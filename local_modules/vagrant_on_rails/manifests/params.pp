class vagrant_on_rails::params {
  $ruby_version    = '1.9.3-p392'
  $app_name        = $::hostname
  $app_root        = "/srv/${app_name}"
  $web_root        = "${app_root}/public"
  $socket_dir      = "/var/run/${app_name}"
  $socket_path     = "${socket_dir}/puma.sock"
  $server_name     = $::fqdn
}

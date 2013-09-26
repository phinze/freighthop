class freighthop::params {
  $database_flavors = []
  $databases        = []
  $database_users   = []
  $packages         = []
  $ppas             = []
  $languages        = []
  $ruby_version     = '1.9.3-p392'
  $app_name         = $::hostname
  $app_root         = "/srv/${app_name}"
  $web_root         = "${app_root}/public"
  $web_port         = 3000
  $server_name      = $::fqdn
  $ssl_cert_path    = "/etc/ssl/certs/${app_name}.pem"
  $ssl_key_path     = "/etc/ssl/private/${app_name}.key"
}

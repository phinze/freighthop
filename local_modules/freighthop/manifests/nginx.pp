class freighthop::nginx(
  $upstream_web_port,
  $server_name,
  $web_root,
  $ssl_cert_path,
  $ssl_key_path,
) {
  $cert_subject = "/C=US/ST=IL/L=Chicago/O=Instructure/CN=${server_name}"

  class {'::nginx':
    confd_purge => true
  }

  exec { 'generate-self-signed-ssl-cert':
    command => "openssl req -x509 -nodes -days 3650 -subj '${cert_subject}' -newkey rsa:1024 -keyout ${ssl_key_path} -out ${ssl_cert_path}",
    path    => ['/usr/bin'],
    creates => $ssl_cert_path,
  }

  file { '/etc/nginx/conf.d/vagrant-rails.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('freighthop/nginx/vagrant-rails.conf.erb'),
    notify  => Service['nginx'],
    require => Exec['generate-self-signed-ssl-cert'],
  }
}

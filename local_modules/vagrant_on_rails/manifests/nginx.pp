class vagrant_on_rails::nginx(
  $upstream_socket_path,
  $server_name,
  $web_root,
) {
  class {'::nginx':
    confd_purge => true
  }
  file { '/etc/nginx/conf.d/vagrant-rails.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('vagrant_on_rails/nginx/vagrant-rails.conf.erb'),
    notify  => Service['nginx'],
  }
}

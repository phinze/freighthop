class vagrant_on_rails(
  $databases,
  $database_users,
  $packages     = ['git-core'],
  $ruby_version = $vagrant_on_rails::params::ruby_version,
  $app_name     = $vagrant_on_rails::params::app_name,
  $app_root     = $vagrant_on_rails::params::app_root,
  $web_root     = $vagrant_on_rails::params::web_root,
  $socket_dir   = $vagrant_on_rails::params::socket_dir,
  $socket_path  = $vagrant_on_rails::params::socket_path,
  $server_name  = $vagrant_on_rails::params::server_name,
) inherits vagrant_on_rails::params {
  file { $socket_dir:
    ensure => directory,
    owner  => 'vagrant',
    group  => 'vagrant',
    mode   => '0755'
  }
  class { 'vagrant_on_rails::rbenv':
    ruby_version => $ruby_version
  }
  class { 'vagrant_on_rails::nginx':
    upstream_socket_path => $socket_path,
    server_name          => $server_name,
    web_root             => $web_root,
  }
  class { 'vagrant_on_rails::postgres':
    databases      => $databases,
    database_users => $database_users,
  }
  class { 'vagrant_on_rails::pkgs':
    packages => $packages,
  }

  exec { 'bundle install':
    environment => [
      'BUNDLE_GEMFILE=Gemfile.vagrant-on-rails',
      'RBENV_ROOT=/usr/lib/rbenv',
      "RBENV_VERSION=${ruby_version}",
    ],
    cwd         => $app_root,
    path        => [
      '/usr/lib/rbenv/shims',
      '/usr/bin',
      '/bin',
    ],
    logoutput   => true,
    timeout     => 0,
    unless      => 'bundle check',
  }

  class { 'vagrant_on_rails::puma':
    app_root    => $app_root,
    socket_path => $socket_path,
  }

  File[$socket_dir] ->
    Class['vagrant_on_rails::pkgs'] ->
    Class['vagrant_on_rails::rbenv'] ->
    Class['vagrant_on_rails::nginx'] ->
    Class['vagrant_on_rails::postgres'] ->
    Exec['bundle install'] ->
    Class['vagrant_on_rails::puma']

}

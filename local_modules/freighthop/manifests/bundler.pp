class freighthop::bundler(
  $ruby_version,
  $app_root,
){
  file { "${app_root}/.freighthop.gemfile":
    ensure => 'file',
    mode   => '0644',
    source => 'puppet:///modules/freighthop/bundler/freighthop.gemfile',
  }

  file { '/etc/profile.d/custom_bundler_gemfile.sh':
    ensure  => present,
    mode    => '0755',
    content => template('freighthop/profile/custom_bundler_gemfile.sh.erb'),
  }

  exec { 'bundle install':
    environment => [
      'BUNDLE_GEMFILE=.freighthop.gemfile',
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
    require     => File["${app_root}/.freighthop.gemfile"],
  }
}

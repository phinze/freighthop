class freighthop::bundler(
  $ruby_version,
  $app_root,
){
  file { "${app_root}/Gemfile.freighthop":
    ensure => 'file',
    mode   => '0644',
    source => 'puppet:///modules/freighthop/bundler/Vagrantfile.freighthop',
  }

  exec { 'bundle install':
    environment => [
      'BUNDLE_GEMFILE=Gemfile.freighthop',
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
    require     => File["${app_root}/Gemfile.freighthop"],
  }
}

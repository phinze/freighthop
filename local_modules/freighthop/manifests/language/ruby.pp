class freighthop::language::ruby(
  $version
){
  class { '::rbenv':
    global_version => $version,
  }

  rbenv::version { $version: }

  # The rbenv puppet module drops $RBENV_ROOT/version but the package from
  # ppa:gds/govuk is an older version of rbenv that expects $RBENV_ROOT/global;
  # this is a workaround that uses the installed CLI to fix it.
  exec { 'fix-rbenv-global-version':
    command     => "rbenv global ${version}",
    unless      => "rbenv global | grep '${version}'",
    environment => 'RBENV_ROOT=/usr/lib/rbenv',
    require     => Rbenv::Version[$version]
  }

  Exec {
    path => [
      '/usr/local/bin',
      '/usr/bin',
      '/usr/sbin',
      '/bin',
      '/sbin',
    ]
  }

}

class vagrant_on_rails::rbenv(
  $ruby_version
) {
  include apt
  apt::ppa { 'ppa:gds/govuk': }

  class { '::rbenv':
    global_version => $ruby_version,
    require        => Apt::Ppa['ppa:gds/govuk'],
  }
  rbenv::version { $ruby_version: }

  # The rbenv puppet module drops $RBENV_ROOT/version but the package from
  # ppa:gds/govuk is an older version of rbenv that expects $RBENV_ROOT/global;
  # this is a workaround that uses the installed CLI to fix it.
  exec { 'fix-rbenv-global-version':
    command     => "rbenv global ${ruby_version}",
    unless      => "rbenv global | grep '${ruby_version}'",
    environment => 'RBENV_ROOT=/usr/lib/rbenv',
    require     => Rbenv::Version[$ruby_version]
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

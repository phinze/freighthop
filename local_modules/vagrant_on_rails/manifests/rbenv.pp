class vagrant_on_rails::rbenv(
  $ruby_version
) {
  include apt
  apt::ppa { 'ppa:gds/govuk': }

  class { '::rbenv': global_version => $ruby_version }
  rbenv::version { $ruby_version: }

  # The rbenv puppet module drops $RBENV_ROOT/version but the package from
  # ppa:gds/govuk is an older version of rbenv that expects $RBENV_ROOT/global;
  # this is a workaround that uses the installed CLI to fix it.
  exec { 'fix-rbenv-global-version':
    command => "/usr/bin/rbenv global ${ruby_version}",
    unless  => "/usr/bin/rbenv global | grep '${ruby_version}'",
    require => Rbenv::Version[$ruby_version]
  }
}

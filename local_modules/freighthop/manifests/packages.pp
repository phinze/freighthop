class freighthop::packages(
  $ppas,
  $packages,
  $languages,
) {
  if (member($languages, 'ruby')) {
    apt::ppa { 'ppa:gds/govuk': }
    apt::ppa { 'ppa:phinze/rbenv': }
  }
  apt::ppa { $ppas: }

  package { [
    'build-essential',
    'git-core',
  ]:
    ensure => installed,
  }

  package { $packages:
    ensure  => installed,
    require => Apt::Ppa[$ppas]
  }
}

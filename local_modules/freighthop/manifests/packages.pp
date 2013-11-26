class freighthop::packages(
  $ppas,
  $packages,
  $languages,
) {
  apt::ppa { $ppas: }

  package { [
    'build-essential',
    'git',
  ]:
    ensure => installed,
  }

  package { $packages:
    ensure  => installed,
    require => Apt::Ppa[$ppas]
  }
}

class freighthop::packages(
  $ppas,
  $packages,
) {
  include apt

  apt::ppa { $ppas: }

  package { $packages:
    ensure  => installed,
    require => Apt::Ppa[$ppas]
  }
}

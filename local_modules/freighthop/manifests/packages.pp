class freighthop::packages(
  $ppas,
  $packages,
) {
  apt::ppa { 'ppa:gds/govuk': }
  apt::ppa { 'ppa:phinze/rbenv': }
  apt::ppa { $ppas: }

  package { $packages:
    ensure  => installed,
  }
}

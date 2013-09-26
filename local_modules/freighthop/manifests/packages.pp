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

  package { $packages:
    ensure  => installed,
  }
}

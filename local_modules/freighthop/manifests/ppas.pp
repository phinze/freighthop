class freighthop::ppas(
  $ppas
) {
  # required ppas
  apt::ppa { 'ppa:gds/govuk': }
  apt::ppa { 'ppa:phinze/rbenv': }

  apt::ppa { $ppas: }
}

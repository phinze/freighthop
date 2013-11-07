class freighthop::database(
  $flavors
) {
  if (member($flavors, 'postgres')) {
    class { 'freighthop::database::postgres':}
  }
  if (member($flavors, 'mysql')) {
    class { 'freighthop::database::mysql':}
  }
}

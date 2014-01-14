class freighthop::database(
  $servers = []
) {
  if member($servers, 'postgres') {
    class { 'freighthop::database::postgres':}
  }
  if member($servers, 'mysql') {
    class { 'freighthop::database::mysql':}
  }
}

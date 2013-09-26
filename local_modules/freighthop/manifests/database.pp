class freighthop::database(
  $database_flavors,
  $databases,
  $database_users
) {
  if (member($database_flavors, 'postgres')) {
    class { 'freighthop::database::postgres':
      databases      => $databases,
      database_users => $database_users,
    }
  }
}

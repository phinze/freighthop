class freighthop::database::mysql(
  $databases,
  $users,
) {
  include mysql::server
  include mysql::client

  mysql_database { $databases: } ->
  freighthop::database::mysql::grant { $users: }
}

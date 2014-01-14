define freighthop::database::mysql::grant(
  $user
) {
  mysql_grant { "freighthop_mysql_grant_for_${user}":
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => '*.*',
    user       => "${user}@%",
  }
}

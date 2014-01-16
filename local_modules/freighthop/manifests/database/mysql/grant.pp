define freighthop::database::mysql::grant(
  $user = $title,
) {
  mysql_grant { "freighthop_mysql_grant_for_${user}_localhost":
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => '*.*',
    user       => "${user}@localhost",
  }
  mysql_grant { "freighthop_mysql_grant_for_${user}_external":
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => '*.*',
    user       => "${user}@%",
  }
}

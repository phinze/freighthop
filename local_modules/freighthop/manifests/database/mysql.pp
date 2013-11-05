class freighthop::database::mysql(
  $db_names,
  $users,
) {
  include mysql::server

  mysql::db{$db_names:
    user => "notorious",
    password => "notorious",
    host => "localhost",
    grant => ['All']
  }
  mysql_grant { $users:
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => '*.*',
    user       => 'notorious@%',
  }
}
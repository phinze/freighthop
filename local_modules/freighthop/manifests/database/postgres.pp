class freighthop::database::postgres(
  $databases,
  $database_users,
) {
  include postgresql::server

  postgresql::pg_hba_rule { 'local-users-get-everything':
    type        => 'local',
    database    => 'all',
    user        => 'all',
    auth_method => 'trust',
    order       => '0001',
  }
  postgresql::pg_hba_rule { 'local-host-connections-get-everything':
    type        => 'host',
    database    => 'all',
    user        => 'all',
    address     => '127.0.0.1/32',
    auth_method => 'trust',
    order       => '0001',
  }
  postgresql::database { $databases: }
  postgresql::database_user { $database_users:
    superuser     => true,
    createdb      => true,
    createrole    => true,
  }
}

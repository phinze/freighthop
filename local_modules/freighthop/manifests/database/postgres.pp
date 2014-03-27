class freighthop::database::postgres(
  $databases,
  $users,
  $version = "9.1",
) {
  class { 'postgresql::globals':
    version => $version,
    manage_package_repo => true
  } ->
  class { 'postgresql::server': }

  postgresql::server::pg_hba_rule { 'local-users-get-everything':
    type        => 'local',
    database    => 'all',
    user        => 'all',
    auth_method => 'trust',
    order       => '0001',
  }
  postgresql::server::pg_hba_rule { 'local-host-connections-get-everything':
    type        => 'host',
    database    => 'all',
    user        => 'all',
    address     => '127.0.0.1/32',
    auth_method => 'trust',
    order       => '0001',
  }
  postgresql::server::database { $databases: }
  postgresql::server::role { $users:
    superuser     => true,
    createdb      => true,
    createrole    => true,
  }
}

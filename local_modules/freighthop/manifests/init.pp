class freighthop(
  $ppas,
  $packages,
  $languages,
) {
  class { 'freighthop::params': } ->
  class { 'freighthop::packages':
    ppas      => $ppas,
    packages  => $packages,
  } ->

  class { 'freighthop::language':
    languages    => $languages,
  } ->

  class { 'freighthop::web': } ->
  class { 'freighthop::database':}
}

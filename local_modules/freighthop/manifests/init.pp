class freighthop(
  $ppas        = $freighthop::params::ppas,
  $packages    = $freighthop::params::packages,
  $languages   = $freighthop::params::languages,
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

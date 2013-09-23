class freighthop::pkgs(
  $packages
) {
  package { $packages:
    ensure  => installed,
  }
}

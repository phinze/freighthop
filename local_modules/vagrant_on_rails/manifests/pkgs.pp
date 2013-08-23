class vagrant_on_rails::pkgs(
  $packages
) {
  package { $packages:
    ensure => installed
  }
}

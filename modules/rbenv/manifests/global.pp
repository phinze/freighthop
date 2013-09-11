# == Class: rbenv::global
#
# Set a Ruby version as the global. This is intended to be called by the
# parent `Rbenv` class. It should not be called directly.
#
# === Parameters:
#
class rbenv::global {
  include rbenv::params

  $version = $::rbenv::global_version

  $require_real = $version ? {
    'system' => undef,
    default  => Rbenv::Version[$version],
  }
  file { $rbenv::params::global_version:
    ensure  => present,
    content => "${version}\n",
    require => $require_real,
  }
}

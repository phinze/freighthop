# == Class: rbenv
#
# Install rbenv from a system package and create an `/etc/profile.d` to do
# the following for all new shell sessions:
#
# - Set `RBENT_ROOT` to a common system path.
# - Run `rvenv init`.
#
# === Parameters:
#
# [*global_version*]
#   Version to use. A matching `Rbenv::Version[]` resource must exist,
#   unless `system` is specified.
#   Default: system
#
class rbenv(
  $global_version = 'system'
) {
  include rbenv::params

  package { 'rbenv':
    ensure => present,
  } ->
  file { '/etc/profile.d/rbenv.sh':
    ensure  => present,
    mode    => '0755',
    content => template('rbenv/etc/profile.d/rbenv.sh.erb'),
  } ->
  class { 'rbenv::global': }
}

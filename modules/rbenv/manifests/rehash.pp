# == Define: rbenv::rehash
#
# Run `rbenv rehash` for a specific version of Ruby. Typically refreshed by
# `Rbenv::Version[]` after installation.
#
# The title of the resource is used as the version.
#
# NB: Exec[] resources do not assume that rbenv has been initialised from
# `profile.d` because Puppet may be running from a non-login and
# non-interactive shell (e.g. cron). They explicitly pass `RBENV_ROOT` and
# reference `rbenv exec` (rather than the shim) for this reason.
#
# TODO: Does this need to be version specific?
#
define rbenv::rehash() {
  include rbenv::params

  $version = $title

  exec { "rbenv rehash for ${version}":
    command     => "${rbenv::params::rbenv_binary} rehash",
    environment => [
      "RBENV_ROOT=${rbenv::params::rbenv_root}",
      "RBENV_VERSION=${version}",
    ],
    refreshonly => true,
  }
}

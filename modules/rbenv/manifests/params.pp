# == Class: rbenv::params
#
# Common variables referred to by other sub-classes.
#
class rbenv::params {
  case $::osfamily {
    'Debian': {
      $rbenv_root     = '/usr/lib/rbenv'
      $rbenv_binary   = '/usr/bin/rbenv'
      $global_version = "${rbenv_root}/version"
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}

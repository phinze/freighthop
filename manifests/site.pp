node default {
  group { 'deploy': ensure => 'present' }
  user { 'deploy':
    ensure => 'present',
    gid    => 'deploy'
  }
  rbenv::install { 'deploy': }
  rbenv::compile { '1.9.3-p327': user => 'deploy' }

}

class freighthop::language::ruby(
  $version = $freighthop::params::ruby_version
){
  rbenv::install { 'vagrant': }
  rbenv::compile { $version:
    global => true,
    user   => 'vagrant',
  }
}

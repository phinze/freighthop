class freighthop::language::ruby(
  $version
){
  rbenv::install { 'vagrant': }
  rbenv::compile { $version:
    global => true,
    user   => 'vagrant',
  }
}

class freighthop::language(
  $languages,
  $ruby_version
) {
  if (member($languages, 'ruby')) {
    class { 'freighthop::language::ruby':
      version => $ruby_version,
    }
  }
}

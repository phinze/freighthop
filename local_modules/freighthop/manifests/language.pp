class freighthop::language(
  $languages,
) {
  if (member($languages, 'ruby')) {
    class { 'freighthop::language::ruby': }
  }
  if (member($languages, 'clojure')) {
    class { 'freighthop::language::clojure':
    }
  }
}

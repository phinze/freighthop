# == Define: rbenv::alias
#
# Create an alias from one version of Ruby to an installed one. Can be used
# to abstract patch numbers from Ruby semvers.
#
# The title of the resource is used as the aliased version.
#
# === Parameters
#
# [*to_version*]
#   Real version to link to. Depends on a matching `Rbenv::Version[]`
#   resource.
#
# === Examples
#
# rbenv::version { '1.9.3-p123': }
# rbenv::alias { '1.9.3':
#   to_version => '1.9.3-p123',
# }
#
define rbenv::alias(
  $to_version
) {
  $version = $title
  $versions_path = '/usr/lib/rbenv/versions'

  file { "${versions_path}/${version}":
    ensure  => link,
    target  => $to_version,
    require => Rbenv::Version[$to_version],
  }
}

class freighthop::language::clojure(
){
  $lein_url = 'https://github.com/technomancy/leiningen/raw/stable/bin/lein'
  $lein_home = '/usr/local/lein'

  package { 'leiningen/java':
    name => 'openjdk-6-jdk'
  } ->

  package { 'leiningen/install-wget':
    name   => 'wget',
  } ->

  exec { 'leiningen/download-script':
    cwd     => '/usr/local/bin',
    command => "wget ${lein_url} && chmod 755 lein",
    creates => '/usr/local/bin/lein',
  } ->

  file { '/etc/profile.d/leiningen.sh':
    content => template('freighthop/profile/leiningen.sh.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  Exec {
    path => [
      '/usr/local/bin',
      '/usr/bin',
      '/usr/sbin',
      '/bin',
      '/sbin',
    ]
  }
}

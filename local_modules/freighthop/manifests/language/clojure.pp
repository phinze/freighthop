class freighthop::language::clojure(
){
  $lein_url = 'https://github.com/technomancy/leiningen/raw/stable/bin/lein'
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

  exec { 'leiningen/self-install':
    environment => [
      'LEIN_HOME=/usr/local/var/lein',
      'LEIN_ROOT=1',
    ],
    command     => 'lein self-install',
    creates     => '/usr/local/var/lein',
  } ->

  file { '/etc/profile.d/global_leiningen.sh':
    content => template('freighthop/profile/global_leiningen.sh.erb'),
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

class rvm::packages::common {
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }
  
  file { '/tmp/rvm':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    require => Exec['download-rvm-install'],
  }
  exec { 'download-rvm-install':
    command => 'wget -O /tmp/rvm https://rvm.beginrescueend.com/install/rvm',
    creates => '/tmp/rvm',
  }
  exec { 'install-rvm':
    command => "bash /tmp/rvm",
    creates => '/usr/local/rvm/bin/rvm',
    require => Exec['download-rvm-install'],
  }
}
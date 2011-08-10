define rvm::user {
  $username = $title
  $group    = 'rvm' 

  exec { "/usr/sbin/usermod -a -G $group $username":
      unless => "/bin/cat /etc/group | grep $group | grep $username",
      require => [User[$username], Class['rvm']];
  }
}
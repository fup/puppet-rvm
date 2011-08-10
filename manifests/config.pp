class rvm::config(
  $version
) {
  
  # Special Grep Logic for setting RVM default version
  # This logic is a blunt sword at best right now, should
  # be cleaned up at some point in the future - JDF 2011/08/10
  if $version == 'ree' {
    $grep_string = 'Ruby Enterprise Edition'
  } else {
    $grep_string = $version
  }

  # Resource Defaults
  Exec {
     path => '/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/rvm/bin/',
  }
  File {
    owner => 'root',
    group => 'root',
    mode  => '0400',
  }
  
  ## Begin configuration
  exec { 'install-ruby':
    command => "rvm install ${version}",
    logoutput => 'true',
    unless  => "/usr/local/rvm/bin/rvm list | grep ${version}",
  }
}
# Class: rvm::package::common
#
# Description
#   This class is designed to install rvm from a script online.
#
# Parameters:
#  This class takes no parameters
#
# Actions:
#  This class is designed to install RVM. 
#
# Requires:
#   - wget
#   - tar
#
# Sample Usage:
#   This method should not be called directly.
#
class rvm::packages::common {
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/lib/rvm/bin',
  }
  
  #exec { 'download-rvm-install':
  #  command => 'wget -O /tmp/rvm https://rvm.beginrescueend.com/install/rvm',
  #  creates => '/tmp/rvm',
  #  unless  => 'which rvm',
  #}
  #exec { 'install-rvm':
  #  command => "bash /tmp/rvm",
  #  creates => '/usr/local/rvm/bin/rvm',
  #  require => [ Exec['download-rvm-install'], Package['git'] ],
  #}
  #file { '/tmp/rvm':
  #  ensure  => absent,
  #  require => Exec['install-rvm'],
  #}
}

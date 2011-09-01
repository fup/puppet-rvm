# Class: rvm::config
#
# Description
#  This class is designed to configure the system to use RVM on the system
#  after packages have been deployed. 
#
# Parameters:
#  This class takes no parameters
# 
# Actions:
#  Configures Gem to not install ri or rdoc packages.
#
# Requires:
#  This module has no requirements
#
# Sample Usage:
#  This module should not be called directly.
#
class rvm::config {
  file { '/etc/gemrc':
    owner  => 'root',
    group  => 'root',
    mode   => '0444',
    source => 'puppet:///modules/rvm/etc/gemrc',
  }
}

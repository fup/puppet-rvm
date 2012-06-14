# Class: rvm::packages
#
# Description
#   This class is designed to properly select the appropriate
#   package class based on operating system. This class is called from
#   Class rvm.
#
# Parameters:
#  This class takes no parameters
#
# Actions:
#   This class is designed to properly select the appropriate
#   package class based on operating system.
#
# Requires:
#   This module has no requirements.
#
# Sample Usage:
#   This method should not be called directly.
#
class rvm::packages {
  anchor { 'rvm::packages::begin': }
  anchor { 'rvm::packages::end': }

  case $::operatingsystem {
    redhat,oel,centos,fedora: {
      class { 'rvm::packages::redhat':
        require => Anchor['rvm::packages::begin'],
        before  => Class['rvm::packages::common'],
      }
    }
  }

  class { 'rvm::packages::common':
    before  => Anchor['rvm::packages::end'],
  }
}

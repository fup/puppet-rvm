# Class: rvm::package::redhat
#
# Description
#   This class is designed to install RVM packages
#   on RHEL based systems. 
#
# Parameters:
#  This class takes no parameters
#
# Actions:
#  This class installs RPMs for RHEL systems.
#
# Requires:
#  This module has no requirements.   
#
# Sample Usage:
#  This method should not be called directly.
#
class rvm::packages::redhat {
  $package_list = ['gcc-c++', 'patch', 'readline', 'readline-devel', 'zlib', 
                   'zlib-devel', 'libyaml-devel', 'libffi-devel', 
                   'openssl-devel', 'make', 'bzip2', 'rvm-ruby' ]

  # Virtualize Package list to prevent conflicts
  @package { $package_list:
    ensure => 'present',
    tag    => 'rvm-packages',
  }

  # Realize packages list. 
  Package<| tag == 'rvm-packages' |>
}

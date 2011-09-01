# Class: rvm
#
# Description
#   RVM is the Ruby Version Manager. It allows you to install and manage several 
#   different versions and implementations of Ruby on one computer, including the 
#   ability to manage different sets of RubyGems one each.
#
# Parameters:
#   This module takes no parameters directly. Reference ruby::define::{gem,user,version} for 
#   rvm management.
#
# Actions:
#   Installs RVM, manages active versions, and can install gems for specific
#   RVM instances.   
#
# Requires:
#   - Development Libraries: RVM manually compiles ruby, and requires dev libraries to bootstrap
#   - Class[stdlib]. This is Puppet Labs standard library to include additional methods for use within Puppet. [https://github.com/puppetlabs/puppetlabs-stdlib]
#
# Sample Usage:
#
#  Install Ruby 1.8.7 and set as the default system ruby.
#
#   rvm::define::version { 'ruby-1.8.7':
#     ensure => 'present',
#     system => 'true',
#   }
#   
#  Install Ruby Enterprise
#
#   rvm::define::version { 'ree':
#     ensure => 'present',
#   }
#
#  Install Gem to specific RVM version
#
#   rvm::define::gem { 'puppet':
#     ensure       => 'present',
#     gem_version  => '2.7.2',
#     ruby_version => 'ree',
#   }
#
class rvm {
  include stdlib
  
  anchor { 'rvm::begin': }
  anchor { 'rvm::end': }
  
  class { 'rvm::packages':
    require => Anchor['rvm::begin'],
    before  => Class['rvm::config'],
  }
  class { 'rvm::config': 
    before => Anchor['rvm::end'],
  }
}

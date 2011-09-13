# Defintion: rvm::define::version
# 
# Description
#  This custom definition will install a specific RVM Ruby version.
#
# Parameters:
#  - $ensure: (present|absent) - ensures the package is either installed or not.
#  - $system: sets whether an installed RVM version will be the system ruby version.
#
# Actions:
#  - Installs RVM ruby version and optionally sets as the system ruby
#
# Requires:
#  - Class[rvm]
#
# Sample Usage:
#  Install Ruby 1.8.7 and set as the default system ruby.
#
#   rvm::define::version { 'ruby-1.8.7':
#     ensure => 'present',
#     system => 'true',
#   }
#   
#  Install Ruby Enterprise
#
#   rvm::define::version { 'ree-1.8.7-2011.03':
#     ensure => 'present',
#   }
#
#   Note: You must define the full version when defining a path. If you
#   happen to simply define version as 'ree', RVM will install the 
#   appropriate ruby, but Puppet will attempt to install the Ruby Version
#   on each puppet run. You've been warned. 
#
define rvm::define::version (
  $ensure = 'present',
  $system = 'false'
) {
  include rvm

  ## Set sensible defaults for Exec resource
  Exec {
    path    => '/usr/lib/rvm/bin:/bin:/sbin:/usr/bin:/usr/sbin',
  }

  # Local Parameters
  $rvm_ruby = '/usr/lib/rvm/rubies'

  # Install or uninstall RVM Ruby Version
  if $ensure == 'present' {
    exec { "install-ruby-${name}":
      command => "rvm install ${name}",
      creates => "${rvm_ruby}/${name}",
      timeout => '0',
      require => Class['rvm'],
    }
  } elsif $ensure == 'absent' {
    exec { "uninstall-ruby-${name}":
      command => "rvm uninstall ${name}",
      onlyif  => "find ${rvm_ruby}/${name}",
      require => Class['rvm'],
    }
  }

  # Establish Default System Ruby.
  # Only create one instance to prevent multiple ruby
  # versions from attempting to be system default.
  if ($system == 'true') and ($ensure != 'absent') {
    exec { 'set-default-ruby-rvm':
      command => "rvm --default use ${name}",
      unless  => "rvm current | grep ${name}",
      require => [Class['rvm'], Exec["install-ruby-${name}"]],
    }
  }
}

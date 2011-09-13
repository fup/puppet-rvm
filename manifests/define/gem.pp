# Defintion: rvm::define::gem
# 
# Description
#  This custom definition will install a gem to a specific RVM version if the default
#  system ruby is not the desired installation with gem or the gem package provider.
#
# Parameters:
#  - $ensure: (present|absent) - ensures the package is either installed or not.
#  - $ruby_version: the specific ruby version via RVM that a gem should be installed to.
#  - $gem_version: the specific version of a gem that you wish to be installed.
#
# Actions:
#  - Installs a gem to a specific Ruby set.
#
# Requires:
#  - Class[rvm]
#
# Sample Usage:
#  Install Gem to specific RVM version
#   rvm::define::gem { 'puppet':
#     ensure       => 'present',
#     gem_version  => '2.7.2',
#     ruby_version => 'ree',
#   }
#
define rvm::define::gem(
  $ensure = 'present',
  $ruby_version,
  $gem_version = '',
  $source = ''
) {  
  ## Set sensible defaults for Exec resource
  Exec {
    path    => '/usr/lib/rvm/bin:/bin:/sbin:/usr/bin:/usr/sbin',
  }
  
  # Local Parameters
  $rvm_path = '/usr/lib/rvm'
  $rvm_ruby = "${rvm_path}/rubies"
  
  # Setup proper install/uninstall commands based on gem version.
  if $gem_version == '' {
    if $source != '' {
      $gem = {
        'install'   => "rvm ${ruby_version} gem install ${name} --no-ri --no-rdoc ${source}",
        'uninstall' => "rvm ${ruby_version} gem uninstall ${name}",
        'lookup'    => "rvm gem list | grep ${name}",
      }
    }
    else {
      $gem = {
        'install'   => "rvm ${ruby_version} gem install ${name} --no-ri --no-rdoc",
        'uninstall' => "rvm ${ruby_version} gem uninstall ${name}",
        'lookup'    => "rvm gem list | grep ${name}",
      }
    }
  } else {
    $gem = {
      'install'   => "rvm ${ruby_version} gem install ${name} -v ${gem_version} --no-ri --no-rdoc",
      'uninstall' => "rvm ${ruby_version} gem uninstall ${name} -v ${gem_version}",
      'lookup'    => "rvm gem list | grep ${name} | grep ${gem_version}",
    }
  }
  
  ## Begin Logic
  if $ensure == 'present' {
    exec { "rvm-gem-install-${name}-${ruby_version}":
      command => $gem['install'],
      unless  => $gem['lookup'],
      require => [Class['rvm'], Exec["install-ruby-${ruby_version}"]],
    }
  } elsif $ensure == 'absent' {
    exec { "rvm-gem-uninstall-${name}-${version}":
      command => $gem['uninstall'],
      onlyif  => $gem['lookup'],
      require => [Class['rvm'], Exec["install-ruby-${ruby_version}"]],
    }    
  }
}

# Defintion: rvm::define::user
# 
# Description
#  This custom definition will add a user to a group that allows them
#  to run RVM without sudo privileges on a system RVM installation
#
# Parameters:
#  This class takes no parameters
#
# Actions:
#  - Adds a user to the group 'rvm'
#
# Requires:
#  - Class[rvm]
#
# Sample Usage:
#  Install Gem to specific RVM version
#
#   $rvm_users = ['james', 'aziz', 'frank']
#   rvm::define::user { $rvm_users: }
#
define rvm::define::user() {
  exec { "/usr/sbin/usermod -a -G rvm ${name}":
      path    => '/bin:/sbin:/usr/bin:/usr/sbin',
      unless  => "cat /etc/group | grep $group | grep $username",
      require => [User[$name], Class['rvm']],
  }
}

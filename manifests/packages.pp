class rvm::packages {
  anchor { 'rvm::packages::begin': }
  anchor { 'rvm::packages::end': }
  
  case $operatingsystem {
    rhel,oel,centos,fedora: {
      class { 'rvm::packages::redhat':
        require => Anchor['rvm::packages::begin'],
      }
    }
  }
  
  class { 'rvm::packages::common':
    before => Anchor['rvm::packages::end'],
  }
}
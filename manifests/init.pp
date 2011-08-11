class rvm {
  include stdlib
  
  anchor { 'rvm::begin': }
  anchor { 'rvm::end': }
  
  class { 'rvm::packages':
    require => Anchor['rvm::begin'],
    before  => Anchor['rvm::end'],
  }
}
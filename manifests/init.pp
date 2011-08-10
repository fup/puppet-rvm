class rvm(
  $version = ''
) {
  include stdlib
  include rvm::params
  
  if $version == '' {
    $REAL_version = $rvm::params::rm_ruby_version
  } else {
    $REAL_version = $version
  }
  
  anchor { 'rvm::begin': }
  anchor { 'rvm::end': }
  
  class { 'rvm::packages':
    require => Anchor['rvm::begin'],
  }
  
  class { 'rvm::config':
    version => $version,
    require => Class['rvm::packages'],
    before  => Anchor['rvm::end'],
  }
}
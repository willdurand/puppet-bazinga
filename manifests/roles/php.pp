# = Role: bazinga::roles::php
#
class bazinga::roles::php {

  $notify_service = defined(Class['php::fpm::service']) ? {
    true    => Class['php::fpm::service'],
    default => undef
  }

  class { '::php': }

  class { 'composer':
    auto_update => true,
    require     => Class['php'],
  }

  package { ['php5-intl', 'php5-curl']:
    ensure  => present,
  }

  php::conf { 'intl':
    source  => 'puppet:///modules/bazinga/php/intl.ini',
    notify  => $notify_service,
    require => Package['php5-intl'],
  }

  php::conf { 'curl':
    source  => 'puppet:///modules/bazinga/php/curl.ini',
    notify  => $notify_service,
    require => Package['php5-curl'],
  }

  $apc_package_prefix = $::operatingsystem ? {
    'ubuntu'     => 'php-',
    default      => 'php5-'
  }

  php::module { 'apc':
    source         => 'puppet:///modules/bazinga/php/apc.ini',
    notify         => $notify_service,
    package_prefix => $apc_package_prefix,
  }
}

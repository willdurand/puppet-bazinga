# = Role: bazinga::roles::php
#
class bazinga::roles::php {

  include ::php::params
  include ::php

  $notify_service = defined(Class['php::fpm::service']) ? {
    true  => Class['php::fpm::service'],
    false => undef
  }

  class { 'composer':
    auto_update => true,
    require     => Class['php'],
  }

  package { ['php5-intl', 'php5-curl']:
    ensure => present,
  }

  php::conf { 'intl':
    source  => 'puppet:///modules/bazinga/php/intl.ini',
    notify  => $notify_service,
    require => Package['php5-intl'],
  }

  file { 'intl-symlink':
    ensure  => absent,
    name    => "${php::params::conf_dir}/20-intl.ini",
    require => Php::Conf['intl'],
  }

  php::conf { 'curl':
    source  => 'puppet:///modules/bazinga/php/curl.ini',
    notify  => $notify_service,
    require => Package['php5-curl'],
  }

  file { 'curl-symlink':
    ensure  => absent,
    name    => "${php::params::conf_dir}/20-curl.ini",
    require => Php::Conf['curl'],
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

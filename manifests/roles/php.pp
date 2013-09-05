# = Role: bazinga::roles::php
#
# == Parameters:
#
# [*cli_ini_content*]
#   php.ini content for cli env
#
# [*cli_ini_source*]
#   php.ini source for cli env
#
class bazinga::roles::php (
  $cli_ini_content = 'UNSET',
  $cli_ini_source  = 'UNSET'
) {

  include ::php::params

  $ini_content = $cli_ini_content ? {
    'UNSET' => undef,
    default => $cli_ini_content
  }

  $ini_source = $cli_ini_source ? {
    'UNSET' => undef,
    default => $cli_ini_source
  }

  class { '::php':
    cli_ini_content => $ini_content,
    cli_ini_source  => $ini_source
  }

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
}

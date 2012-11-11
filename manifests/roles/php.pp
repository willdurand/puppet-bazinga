# = Role: bazinga::roles::php
#
class bazinga::roles::php {

  class { '::php': }

  php::conf { 'default':
    source => 'puppet:///modules/bazinga/php/default.ini',
    notify => Class['php::fpm::service'],
  }

  php::module { 'intl':
    source => 'puppet:///modules/bazinga/php/intl.ini',
    notify => Class['php::fpm::service'],
  }

  php::module { 'curl':
    source => 'puppet:///modules/bazinga/php/curl.ini',
    notify => Class['php::fpm::service'],
  }

  php::module { 'apc':
    source => 'puppet:///modules/bazinga/php/apc.ini',
    notify => Class['php::fpm::service'],
  }
}

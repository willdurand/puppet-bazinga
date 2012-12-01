# = Role: bazinga::roles::php
#
class bazinga::roles::php {

  $notify_service = defined(Class['php::fpm::service']) ? {
    true    => Class['php::fpm::service'],
    default => undef
  }

  class { '::php': }
  class { 'composer': }

  php::conf { 'default':
    source => 'puppet:///modules/bazinga/php/default.ini',
    notify => $notify_service,
  }

  php::module { 'intl':
    source => 'puppet:///modules/bazinga/php/intl.ini',
    notify => $notify_service,
  }

  php::module { 'curl':
    source => 'puppet:///modules/bazinga/php/curl.ini',
    notify => $notify_service,
  }

  php::module { 'apc':
    source => 'puppet:///modules/bazinga/php/apc.ini',
    notify => $notify_service,
  }
}

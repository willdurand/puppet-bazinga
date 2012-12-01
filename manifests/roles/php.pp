# = Role: bazinga::roles::php
#
class bazinga::roles::php {

  class { '::php': }

  class { 'composer': }

  php::conf { 'default':
    source => 'puppet:///modules/bazinga/php/default.ini',
  }

  php::module { 'intl':
    source => 'puppet:///modules/bazinga/php/intl.ini',
  }

  php::module { 'curl':
    source => 'puppet:///modules/bazinga/php/curl.ini',
  }

  php::module { 'apc':
    source => 'puppet:///modules/bazinga/php/apc.ini',
  }
}

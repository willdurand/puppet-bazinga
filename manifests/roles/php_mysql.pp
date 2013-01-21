# = Role: bazinga::roles::php_mysql
#
class bazinga::roles::php_mysql {

  class { 'bazinga::roles::php': }

  package { 'php5-mysql':
    ensure => present,
  }

  php::conf { 'mysqli':
    source => 'puppet:///modules/bazinga/php/mysqli.ini',
    notify => $bazinga::roles::php::notify_service,
  }

  php::conf { 'mysql':
    source => 'puppet:///modules/bazinga/php/mysql.ini',
    notify => $bazinga::roles::php::notify_service,
  }

  php::conf { 'pdo_mysql':
    source => 'puppet:///modules/bazinga/php/pdo_mysql.ini',
    notify => $bazinga::roles::php::notify_service,
  }

  php::conf { 'pdo':
    source => 'puppet:///modules/bazinga/php/pdo.ini',
    notify => $bazinga::roles::php::notify_service,
  }
}

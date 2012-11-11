# = Role: bazinga::roles::php_mysql
#
class bazinga::roles::php_mysql {

  class { 'bazinga::roles::php': }

  package { 'php5-mysql':
    ensure => present,
  }

  php::conf { 'mysqli':
    source => 'puppet:///modules/bazinga/php/mysqli.ini',
    notify => Class['php::fpm::service'],
  }

  php::conf { 'mysql':
    source => 'puppet:///modules/bazinga/php/mysql.ini',
    notify => Class['php::fpm::service'],
  }

  php::conf { 'pdo_mysql':
    source => 'puppet:///modules/bazinga/php/pdo_mysql.ini',
    notify => Class['php::fpm::service'],
  }

  php::conf { 'pdo':
    source => 'puppet:///modules/bazinga/php/pdo.ini',
    notify => Class['php::fpm::service'],
  }
}

# = Class: bazinga::apt
#
class bazinga::apt {

  if $::osfamily == 'debian' {
    apt::source { 'debian':
      location => 'http://ftp.fr.debian.org/debian',
      release  => 'stable',
      repos    => 'main contrib non-free',
    }

    apt::source { 'dotdeb':
      location   => 'http://packages.dotdeb.org',
      release    => 'squeeze-php54',
      repos      => 'all',
      key        => '89DF5277',
      key_server => 'keys.gnupg.net',
    }
  }

  Exec['apt_update'] -> Package <||>
}

# = Class: bazinga::apt
#
class bazinga::apt {

  case $::operatingsystem {
    'ubuntu': {
      apt::source { 'ubuntu':
        location => 'http://archive.ubuntu.com/ubuntu',
        release  => 'lucid',
        repos    => 'main universe multiverse restricted',
      }

      apt::source { 'ondrej-php5':
        location => 'http://ppa.launchpad.net/ondrej/php5/ubuntu',
        release  => 'lucid',
        repos    => 'main',
      }
    }
    'debian': {
      apt::source { 'debian':
        location => 'http://ftp.fr.debian.org/debian',
        release  => 'stable',
        repos    => 'main contrib non-free',
      }

      apt::source { 'dotdeb':
        location => 'http://packages.dotdeb.org',
        release  => 'squeeze-php54',
        repos    => 'all',
        key      => '89DF5277',
      }

      apt::key { 'dotdeb':
        key        => '89DF5277',
        key_source => 'http://www.dotdeb.org/dotdeb.gpg',
      }
    }
    default: {
    }
  }

  Exec['apt_update'] -> Package <||>
}

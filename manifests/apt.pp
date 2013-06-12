# = Class: bazinga::apt
#
class bazinga::apt {

  case $::operatingsystem {
    'ubuntu': {
      apt::source { 'ubuntu':
        location => 'http://archive.ubuntu.com/ubuntu/',
        release  => $::lsbdistcodename,
        repos    => 'main universe multiverse restricted',
      }

      apt::source { 'ubuntu-security':
        location => 'http://archive.ubuntu.com/ubuntu/',
        release  => "${::lsbdistcodename}-security",
        repos    => 'main universe multiverse restricted',
      }

      apt::source { 'ubuntu-updates':
        location => 'http://archive.ubuntu.com/ubuntu/',
        release  => "${::lsbdistcodename}-updates",
        repos    => 'main universe multiverse restricted',
      }

      apt::source { 'ondrej-php5':
        location => 'http://ppa.launchpad.net/ondrej/php5/ubuntu',
        release  => $::lsbdistcodename,
        repos    => 'main',
      }

      apt::key { 'ondrej-php5':
        key        => 'E5267A6C',
        key_server => 'keyserver.ubuntu.com',
      }
    }
    'debian': {
      apt::source { 'debian':
        location => 'http://ftp.fr.debian.org/debian',
        release  => 'stable',
        repos    => 'main contrib non-free',
      }

      $dotdeb_release = $::lsbdistcodename ? {
        'squeeze' => 'squeeze-php54',
        default   => $::lsbdistcodename
      }

      apt::source { 'dotdeb':
        location => 'http://packages.dotdeb.org',
        release  => $dotdeb_release,
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

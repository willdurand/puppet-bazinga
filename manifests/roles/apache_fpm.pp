# = Role: bazinga::roles::apache_fpm
#
# == Parameters:
#
# [*apache_user*]
#   The apache user
#
# [*apache_group*]
#   The apache group
#
# [*listen*]
#   The address to listen
#
class bazinga::roles::apache_fpm (
  $apache_user  = 'UNSET',
  $apache_group = 'UNSET',
  $listen       = '127.0.0.1:9000'
) {

  include ::apache::params

  $user = $apache_user ? {
    'UNSET' => $::apache::params::user,
    default => $apache_user
  }

  $group = $apache_group ? {
    'UNSET' => $::apache::params::group,
    default => $apache_group
  }

  class { 'bazinga::roles::apache':
    apache_user   => $user,
    apache_group  => $group,
  }

  package { 'libapache2-mod-fastcgi':
    ensure  => installed,
    name    => 'libapache2-mod-fastcgi',
    require => Package['httpd'],
  }

  # a2mod resource doesn't work well
  exec { 'a2enmod-actions':
    command => '/usr/sbin/a2enmod actions',
    user    => 'root',
    notify  => Service['httpd'],
    require => Package['httpd'],
    unless  => '/usr/bin/test -f /etc/apache2/mods-enabled/actions.load',
  }

  # a2mod resource doesn't work well
  exec { 'a2enmod-fastcgi':
    command => '/usr/sbin/a2enmod fastcgi',
    user    => 'root',
    notify  => Service['httpd'],
    require => Package['libapache2-mod-fastcgi'],
    unless  => '/usr/bin/test -f /etc/apache2/mods-enabled/fastcgi.load',
  }

  php::fpm::pool { $user:
    user                    => $user,
    group                   => $group,
    listen                  => $listen,
    pm                      => 'dynamic',
    pm_max_children         => 10,
    pm_start_servers        => 2,
    pm_min_spare_servers    => 1,
    pm_max_spare_servers    => 4,
    pm_process_idle_timeout => '20s',
    pm_max_requests         => 1000,
  }

  file { '/var/log/php_errors.log':
    mode => '0777',
  }
}

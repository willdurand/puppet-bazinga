# = Role: bazinga::roles::mysql
#
# == Parameters:
#
# [*root_password*]
#   The mysql root password
#
# [*data_dir*]
#   The data directory
#
# [*bind_address*]
#   The address to bind
#
class bazinga::roles::mysql (
  $root_password = 'UNSET',
  $data_dir      = '/var/lib/mysql',
  $bind_address  = '127.0.0.1'
) {

  class { '::mysql::params': }

  if $data_dir != '/var/lib/mysql' {
    file { $data_dir:
      ensure  => directory,
      owner   => 'mysql',
      group   => 'mysql',
      mode    => '0770',
      before  => Package['mysql-server'],
      require => [ Group['mysql'], User['mysql'] ],
    }

    file { '/var/lib/mysql':
      ensure  => 'link',
      owner   => 'mysql',
      group   => 'mysql',
      mode    => '0770',
      target  => $data_dir,
      require => File[$data_dir],
      before  => Package['mysql-server'],
    }
  }

  group { 'mysql':
    ensure  => present,
    before  => Package['mysql-server'],
  }

  user { 'mysql':
    ensure  => present,
    gid     => 'mysql',
    home    => '/home/mysql',
    require => Group['mysql'],
    before  => Package['mysql-server'],
  }

  class { '::mysql': }
  class { '::mysql::server':
    config_hash => {
      'root_password' => $root_password,
      'bind_address'  => $bind_address,
    }
  }
}

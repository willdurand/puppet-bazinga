# = Role: bazinga::roles::apache
#
# == Parameters:
#
# [*apache_user*]
#   The apache user
#
# [*apache_group*]
#   The apache group
#
class bazinga::roles::apache (
  $apache_user  = 'UNSET',
  $apache_group = 'UNSET'
) {

  include ::apache::params
  include ::apache

  $user = $apache_user ? {
    'UNSET' => $::apache::params::user,
    default => $apache_user
  }

  $group = $apache_group ? {
    'UNSET' => $::apache::params::group,
    default => $apache_group
  }

  group { $group:
    ensure => present,
  }

  if $user != $group {
    user { $user:
      ensure     => present,
      managehome => true,
      groups     => [ $group ],
      require    => Group[$group],
    }
  } else {
    user { $user:
      ensure     => present,
      managehome => true,
      require    => Group[$group],
    }
  }

  file { "/home/${user}/www":
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => '0644',
    require => [ User[$user] ],
  }
}

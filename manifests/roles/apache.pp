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
  $apache_user  = 'UNDEF',
  $apache_group = 'UNDEF'
) {

  include ::apache::params
  include ::apache

  $user = $apache_user ? {
    'UNDEF' => $::apache::params::user,
    default => $apache_user
  }

  $group = $apache_group ? {
    'UNDEF' => $::apache::params::group,
    default => $apache_group
  }


  if $user != $group {
    group { $group:
      ensure => present,
    }

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

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
  $apache_user  = 'www-data',
  $apache_group = 'www-data'
) {

  class { '::apache': }

  user { $apache_user:
    ensure => present,
    groups => [ $apache_user, $apache_group ],
  }
}

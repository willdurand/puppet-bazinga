# = Role: bazinga::roles::rabbitmq
#
# == Parameters:
#
# [*rabbitmq_user*]
#   The rabbitmq user
#
# [*rabbitmq_password*]
#   The rabbitmq password
#
# [*rabbitmq_vhost*]
#   The rabbitmq vhost
#
# [*rabbitmq_port*]
#   The rabbitmq port
#
class bazinga::roles::rabbitmq (
  $rabbitmq_user     = 'guest',
  $rabbitmq_password = 'guest',
  $rabbitmq_vhost    = 'guest',
  $rabbitmq_port     = 5672
) {

  class { '::rabbitmq':
    port => $rabbitmq_port,
  }

  rabbitmq_user { "rabbitmq-user-${rabbitmq_user}":
    ensure   => present,
    name     => $rabbitmq_user,
    admin    => true,
    password => $rabbitmq_password,
    provider => 'rabbitmqctl',
  }

  rabbitmq_vhost { "rabbitmq-vhost-${rabbitmq_vhost}":
    ensure   => present,
    name     => $rabbitmq_vhost,
    provider => 'rabbitmqctl',
  }

  rabbitmq_user_permissions { "${rabbitmq_user}@${rabbitmq_vhost}":
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
    provider             => 'rabbitmqctl',
  }
}

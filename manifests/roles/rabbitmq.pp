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
  $rabbitmq_user,
  $rabbitmq_password,
  $rabbitmq_vhost,
  $rabbitmq_port
) {

  class { 'rabbitmq::repo::apt': }

  class { 'rabbitmq::server':
    port              => $rabbitmq_port,
    delete_guest_user => true,
    require           => Class['rabbitmq::repo::apt'],
  }

  rabbitmq_user { $rabbitmq_user:
    admin    => true,
    password => $rabbitmq_password,
    provider => 'rabbitmqctl',
  }

  rabbitmq_vhost { $rabbitmq_vhost:
    ensure   => present,
    provider => 'rabbitmqctl',
  }

  rabbitmq_user_permissions { "${rabbitmq_user}@${rabbitmq_vhost}":
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
    provider             => 'rabbitmqctl',
    require              => [ Rabbitmq_User[$rabbitmq_user], Rabbitmq_Vhost[$rabbitmq_vhost] ],
  }
}

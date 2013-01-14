# = Define: bazinga::apache_fpm::vhost
#
# == Parameters:
#
# [*server_admin*]
#   The server admin's email
#
# [*doc_root*]
#   Document root, default empty
#
# [*dir_index*]
#   Directory index, default: index.php index.html
#
# [*port*]
#   Port, default: 80
#
# [*priority*]
#   Vhost priority, default: 10
#
# [*fastcgi_host*]
#   fastcgi host, default: 127.0.0.1
#
# [*fastcgi_port*]
#   fastcgi port, default: 9000
#
# [*server_name*]
#   Server name, default $name
#
# [*serveraliases*]
#   Server aliases, default empty
#
# [*allow_override*]
#   Allow override directive, default empty
#
# [*template*]
#   Template, default: bazinga/apache_fpm/vhost.conf.erb
#
# [*log_root*]
#   Log root directory
#
# [*vhost_name*]
#   Vhost name
#
# [*options*]
#   Options
#
# [*ssl_cert*]
#   SSL Certificate
#
# [*ssl_key*]
#   SSL Private Key
#
# [*ssl_chain*]
#   SSL Certificate Chain
#
# [*ssl_ca*]
#   SSL CA Certificate
#
define bazinga::apache_fpm::vhost (
  $server_admin,
  $doc_root       = '',
  $dir_index      = 'index.php index.html',
  $port           = 80,
  $priority       = 10,
  $fastcgi_host   = '127.0.0.1',
  $fastcgi_port   = 9000,
  $server_name    = '',
  $serveraliases  = '',
  $allow_override = 'All',
  $template       = 'bazinga/apache_fpm/vhost.conf.erb',
  $log_root       = '',
  $vhost_name     = '',
  $options        = undef,
  $ssl_cert       = '',
  $ssl_key        = '',
  $ssl_chain      = '',
  $ssl_ca         = ''
) {

  if $doc_root == '' {
    $docroot = "/var/www/${name}"
  } else {
    $docroot = $doc_root
  }

  if $server_name == '' {
    $srvname = $name
  } else {
    $srvname = $server_name
  }

  if $log_root == '' {
    $logroot = "/var/log/${apache::params::apache_name}/"
  } else {
    $logroot = $log_root
  }

  if $vhost_name == '' {
    $vhostname = $apache::params::vhost_name
  }

  if $options == undef {
    $opts = $apache::params::options
  }

  file { "${apache::params::vdir}/${priority}-${name}":
    content => template($template),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['httpd'],
    notify  => Service['httpd'],
  }
}

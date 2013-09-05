# Define: bazinga::php::compile_ext
#
# == Parameters:
#
# [*repository*]
#   The Git repository
#
# [*configure_flags*]
#   Flags to append after the 'configure' command
#
define bazinga::php::compile_ext (
  $repository,
  $configure_flags = 'UNDEF'
) {

  ensure_packages([ 'git' ])

  $tmp_dir = "/tmp/${name}"
  $flags   = $configure_flags ? {
    'UNDEF' => '',
    default => " ${configure_flags}"
  }

  exec { "bazinga-php-compile-ext-${name}-download":
    command => "git clone ${repository} ${tmp_dir}",
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    unless  => "php -m | grep ${name}",
  }

  exec { "bazinga-php-compile-ext-${name}-phpize":
    command => 'phpize',
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    cwd     => $tmp_dir,
    require => [
      Class['bazinga::roles::php'],
      Exec["bazinga-php-compile-ext-${name}-download"]
    ],
    onlyif  => "test -d ${tmp_dir}",
  }

  exec { "bazinga-php-compile-ext-${name}-configure":
    command => "sh configure${flags}",
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    cwd     => $tmp_dir,
    require => Exec["bazinga-php-compile-ext-${name}-phpize"],
    onlyif  => "test -d ${tmp_dir}",
  }

  exec { "bazinga-php-compile-ext-${name}-install":
    command => 'make && make install',
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    cwd     => $tmp_dir,
    require => Exec["bazinga-php-compile-ext-${name}-configure"],
    onlyif  => "test -d ${tmp_dir}",
    unless  => "php -m | grep ${name}",
  }

  file { "bazinga-php-compile-ext-${name}-config-file":
    ensure  => present,
    name    => "${php::params::conf_dir}${name}.ini",
    content => template('bazinga/php/extension.ini.erb'),
    require => Exec["bazinga-php-compile-ext-${name}-install"],
    notify  => defined(Class['php::fpm::service']) ? {
      true  => Class['php::fpm::service'],
      false => undef
    },
  }
}

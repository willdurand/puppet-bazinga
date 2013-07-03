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

  $tmp_dir = "/tmp/${name}"
  $flags   = $configure_flags ? {
    'UNDEF' => '',
    default => " ${configure_flags}"
  }

  exec { "bazinga-php-compile-ext-${name}-download":
    command => "git clone ${repository} ${tmp_dir}",
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    unless  => "test -d ${tmp_dir}",
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
    unless  => "test -f ${php::params::conf_dir}${name}.ini",
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

  exec { "bazinga-php-compile-ext-${name}-clean":
    command => "rm -rf ${tmp_dir}",
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    require => File["bazinga-php-compile-ext-${name}-config-file"],
    onlyif  => "test -d ${tmp_dir}",
  }
}

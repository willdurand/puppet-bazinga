# Define: bazinga::php::set_var
#
# == Parameters:
#
# [*value*]
#   The new value
#
# [*file_ini*]
#   The file to update
#
define bazinga::php::set_var (
  $value,
  $file_ini
) {

  include ::php::params

  exec { "bazinga_php_set_var_${file_ini}_${name}":
    command => "sed -i 's/^;*[[:space:]]*${name}[[:space:]]*=.*$/${name} = ${value}/g' ${file_ini}",
    unless  => "grep -xqe '${name}[[:space:]]*=[[:space:]]*${value}' -- ${file_ini}",
    path    => '/bin:/usr/bin',
    require => Class['bazinga::roles::php'],
    notify  => defined(Service[$::php::params::fpm_service_name]) ? {
      true  => Service[$::php::params::fpm_service_name],
      false => undef
    },
  }
}

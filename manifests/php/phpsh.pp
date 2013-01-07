# = Class: bazinga::php::phpsh
#
# == Parameters:
#
# [*target_dir*]
#   Where to install phpsh.
#
# == Example:
#
#   include bazinga::php::phpsh
#
class bazinga::php::phpsh (
  $target_dir = 'UNDEF'
) {

  $phpsh_tarball_url  = 'http://github.com/facebook/phpsh/tarball/master'
  $phpsh_tarball_name = 'phpsh.tar.gz'
  $phpsh_target_dir   = $target_dir ? {
    'UNDEF' => '/usr/local/phpsh',
    default => $target_dir
  }

  package { 'python-setuptools':
    ensure => present
  }

  exec { 'phpsh-download':
    command => "wget -O ${phpsh_tarball_name} ${phpsh_tarball_url}",
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    cwd     => '/tmp',
    user    => 'root',
    unless  => "test -d ${phpsh_target_dir}",
  }

  exec { 'phpsh-unpack':
    command => "tar xzf ${phpsh_tarball_name} && mv facebook-phpsh* ${phpsh_target_dir}",
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    cwd     => '/tmp',
    user    => 'root',
    unless  => "test -d ${phpsh_target_dir}",
    require => Exec['phpsh-download'],
  }

  exec { 'phpsh-install':
    command => 'python setup.py install',
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    cwd     => $phpsh_target_dir,
    user    => 'root',
    unless  => "test -d ${phpsh_target_dir}/build",
    require => [
      Exec['phpsh-download'],
      Package['python-setuptools']
    ],
  }
}

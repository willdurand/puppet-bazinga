# = Role: bazinga::roles::base
#
# == Parameters:
#
# [*vagrant*]
#   Set to `true` if the server is a vagrant VM.
#
class bazinga::roles::base (
  $vagrant = false
) {

  class { '::apt':
    purge_sources_list => true,
  }

  # NTP
  class { 'ntp': }

  # SSH
  package { 'openssh-server':
    ensure => present,
  }

  service { 'ssh':
    ensure     => running,
    hasrestart => true,
    hasstatus  => true,
  }

  # Vagrant
  $ensure_vagrant = $vagrant ? {
    true    => present,
    default => absent
  }

  package { ['nfs-common', 'portmap']:
    ensure => $ensure_vagrant,
  }

  # Common tools
  package { ['screen', 'curl', 'htop', 'ack-grep']:
    ensure => latest,
  }

  package { 'vim':
    name   => $::operatingsystem ? {
      'ubuntu' => 'vim-nox',
      default  => 'vim'
    },
    ensure => latest,
  }
}

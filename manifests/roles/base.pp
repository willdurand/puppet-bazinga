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
    ensure     => present,
  }

  service { 'ssh':
    ensure     => running,
    hasrestart => true,
    hasstatus  => true,
  }

  # Vagrant
  if $vagrant == true {
    # vagrant needs these packages
    package { ['nfs-common', 'portmap']:
      ensure => present,
    }
  } else {
    package { ['nfs-common', 'portmap']:
      ensure => absent,
    }
  }

  # Common tools
  package { ['screen', 'vim', 'curl', 'htop', 'ack-grep']:
    ensure => latest,
  }
}

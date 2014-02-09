# == Class: site::basic_pkgs
#
# This class provides basic package list and configuration
# for packages which need it
# === Authors
#
# Jacopo Binosi <b4inoz@gmail.com>
#

class site::basic_pkgs {
  if $::osfamily != 'windows' {
    package { 'basic_pkgs':
      ensure => installed,
      name   => [
        'vim',
        'byobu',
        'git',
        'rsync',
        'sudo',
      ],
    }
  }
}

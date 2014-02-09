# == Class: site::basic
#
# This class perform OS basic setup
#
# === Authors
#
# Jacopo Binosi <b4inoz@gmail.com>
#

class site::basic {
  if $::osfamily != 'windows' {
    #
    # === Packages
    #
    include site::basic_pkgs

    #
    # === Custom modules
    #
    include core_permissions
    include zsh_arch

    #
    # === Puppet Forge
    #
    include motd
    # Include and setup locales
    class{ 'locales':
      default_value  => 'en_US.UTF-8',
      available      => [
        'en_US ISO-8859-1',
        'en_US.ISO-8859-15 ISO-8859-15',
        'en_US.UTF-8 UTF-8',
        'it_IT ISO-8859-1',
        'it_IT.UTF-8 UTF-8',
        'it_IT@euro ISO-8859-15',
      ],
    }
    # Include and setup alternatives
    alternatives { 'editor':
      path => '/usr/bin/vim.basic',
    }

    #
    # === Users
    #
    group { 'bainos':
      ensure  => present,
      gid     => '39000',
    }
    user { 'bainos':
      ensure            => 'present',
      uid               => '39000',
      gid               => 'bainos',
      groups            => ['sudo'],
      home              => '/home/bainos',
      managehome        => true,
      password_max_age  => '99999',
      password_min_age  => '0',
      shell             => '/usr/bin/zsh',
    }
    class{ 'puppet_vim_env':
      homedir => '/home/bainos',
    }

  }
}

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
    include puppet_vim_env
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
    user { 'root':
      ensure            => 'present',
      comment           => 'root',
      gid               => '0',
      home              => '/root',
      managehome        => true,
      password          => '$6$Y3TGSeWe$KfGijIwB0cguKhOuY.jGRizqOOILyHfu8mqyVgkT8KGhS5/h8N7S7MSMU5iDhyhEJaNV1u9gNyugUc4LQAN3L1',
      password_max_age  => '99999',
      password_min_age  => '0',
      shell             => '/usr/bin/zsh',
      uid               => '0',
    }

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
      password          => '$6$2LYJPfoD$QBDHrCTI1mC762V4GfFDA.U5kWZ9sya1p.I0ej0yQa5dokSPjKkZu671YJlt.8Ny46ToxLZ6STgh7S1vt/JxA0',
      password_max_age  => '99999',
      password_min_age  => '0',
      shell             => '/usr/bin/zsh',
    }

  }
}

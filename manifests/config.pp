class nrpe::config inherits nrpe {

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  if($nrpe::nrpe_user_secondary_groups!=undef)
  {
    user { $nrpe::username:
      groups => $nrpe::nrpe_user_secondary_groups,
    }
  }

  if(defined(Class['::selinux']))
  {
    $current_selinux_mode = $::selinux? {
      bool2boolstr(false) => 'disabled',
      false               => 'disabled',
      default             => $::selinux_current_mode,
    }

    if($nrpe::manage_selinux_booleans)
    {
      case $current_selinux_mode
      {
        /^(enforcing|permissive)$/:
        {
          #!!!! This avc can be allowed using the boolean 'daemons_dump_core'
          selinux::setbool { 'daemons_dump_core':
            value => true,
          }

          #!!!! This avc can be allowed using the boolean 'nagios_run_sudo'
          selinux::setbool { 'nagios_run_sudo':
            value => true,
          }

          #!!!! This avc can be allowed using the boolean 'nis_enabled'
          selinux::setbool { 'nis_enabled':
            value => true,
          }

          exec { 'nrpe selinux dir':
            command => "mkdir -p ${nrpe::selinux_dir}",
            creates => $nrpe::selinux_dir,
          }

          file { "${nrpe::selinux_dir}/nrpe_monit.te":
            ensure  => 'present',
            owner   => 'root',
            group   => 'root',
            mode    => '0400',
            content => template("${module_name}/selinux/policy.erb"),
            require => Exec['nrpe selinux dir'],
          }

          selinux::semodule { 'nrpe_monit':
            basedir => $nrpe::selinux_dir,
            require => File["${nrpe::selinux_dir}/nrpe_monit.te"],
          }
        }
        'disabled': { }
        default: { fail('this should not happen') }
      }
    }
  }

  if($nrpe::params::sysconfig_file!=undef)
  {
    file { $nrpe::params::sysconfig_file:
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template($nrpe::params::sysconfig_template),
    }
  }

  concat { $nrpe::params::nrpe_conf:
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  concat::fragment { 'nrpe.cfg base':
    target  => $nrpe::params::nrpe_conf,
    order   => '00',
    content => template("${module_name}/nrpecfg.erb"),
  }

  concat::fragment { 'nrpe.cfg command base':
    target  => $nrpe::params::nrpe_conf,
    order   => '50',
    content => template("${module_name}/command_base.erb"),
  }

  concat::fragment { 'nrpe.cfg include base':
    target  => $nrpe::params::nrpe_conf,
    order   => '90',
    content => template("${module_name}/include_base.erb"),
  }

  exec { "mkdir p nrpe ${nrpe::nrpe_conf_dir}":
    command => "mkdir -p ${nrpe::nrpe_conf_dir}",
    creates => $nrpe::nrpe_conf_dir,
  }

  file { $nrpe::pid_dir:
    ensure => 'directory',
    owner  => $nrpe::username,
    group  => $nrpe::group,
    mode   => $nrpe::pid_dir_mode,
  }

  file { $nrpe::nrpe_conf_dir:
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => $nrpe::nrpe_conf_recurse,
    purge   => $nrpe::nrpe_conf_purge,
    require => Exec["mkdir p nrpe ${nrpe::nrpe_conf_dir}"],
  }

  if($nrpe::nagios_home!=undef)
  {
    file { $nrpe::nagios_home:
      ensure => 'directory',
      owner  => $nrpe::nagios_home_user,
      group  => $nrpe::nagios_home_group,
      mode   => $nrpe::nagios_home_mode,
    }
  }

}

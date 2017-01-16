class nrpe::params {

  $nrpe_conf='/etc/nagios/nrpe.cfg'
  $pid_file='/var/run/nrpe/nrpe.pid'

  case $::osfamily
  {
    'redhat':
    {
      $service_name='nrpe'
      $include_epel=true
      $package_name='nrpe'
      $plugins_packages_default=[ 'nagios-plugins-nrpe' ]
      $nrpe_conf_dir_default='/etc/nrpe.d'
      $username_default='nrpe'
      $group_default='nrpe'
      $sysconfig_file=undef
      $sysconfig_template=undef

      case $::operatingsystemrelease
      {
        /^[5-7].*$/:
        {
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      $service_name='nagios-nrpe-server'
      $include_epel=false
      $package_name='nagios-nrpe-server'
      $plugins_packages_default=[ 'nagios-plugins-basic' ]
      $nrpe_conf_dir_default='/etc/nagios/nrpe.d'
      $username_default='nagios'
      $group_default='nagios'
      $sysconfig_file='/etc/default/nagios-nrpe-server'
      $sysconfig_template="${module_name}/sysconfig/ubuntu.erb"

      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^1[46].*$/:
            {
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}

class nrpe::params {

  $nrpe_conf='/etc/nagios/nrpe.cfg'


  case $::osfamily
  {
    'redhat':
    {
      $pid_file='/var/run/nrpe/nrpe.pid'
      $service_name='nrpe'
      $include_epel=true
      $package_name='nrpe'
      $plugins_packages_default=[ 'nagios-plugins-nrpe' ]
      $nrpe_conf_dir_default='/etc/nrpe.d'
      $username_default='nrpe'
      $group_default='nrpe'
      $sysconfig_file=undef
      $sysconfig_template=undef
      $ppa_dont_blame=false

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
      $pid_file='/var/run/nagios/nrpe.pid'
      $service_name='nagios-nrpe-server'
      $include_epel=false
      $package_name='nagios-nrpe-server'
      $plugins_packages_default=[ 'nagios-plugins-basic', 'nagios-nrpe-plugin' ]
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
            /^14.*$/:
            {
              $ppa_dont_blame=false
            }
            /^16.*$/:
            {
              $ppa_dont_blame=true
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    'Suse':
    {
      $pid_file='/var/run/nrpe/nrpe.pid'
      $service_name='nrpe'
      $include_epel=false
      $package_name='nagios-nrpe'
      $plugins_packages_default=[ 'nagios-plugins-nrpe' ]
      $nrpe_conf_dir_default='/etc/nagios/nrpe.d'
      $username_default='nagios'
      $group_default='nagios'
      $sysconfig_file=undef
      $sysconfig_template=undef
      $ppa_dont_blame=false

      case $::operatingsystem
      {
        'SLES':
        {
          case $::operatingsystemrelease
          {
            '11.3':
            {
            }
            default: { fail("Unsupported operating system ${::operatingsystem} ${::operatingsystemrelease}") }
          }
        }
        default: { fail("Unsupported operating system ${::operatingsystem}") }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}

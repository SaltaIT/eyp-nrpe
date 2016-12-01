class nrpe::params {

  $service_name='nrpe'

  $nrpe_conf='/etc/nagios/nrpe.cfg'

  case $::osfamily
  {
    'redhat':
    {
      $include_epel=true

      $package_name='nrpe'

      $plugins_package_name='nagios-plugins-nrpe'

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
      $include_epel=false

      $package_name='nagios-nrpe-server'

      $plugins_package_name='nagios-nrpe-plugin'

      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^14.*$/:
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

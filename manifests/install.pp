class nrpe::install inherits nrpe {

  if($nrpe::manage_package)
  {
    if($nrpe::params::ppa_dont_blame)
    {
      include ::apt

      apt::ppa { 'ppa:dontblamenrpe/ppa':
        ensure => 'present',
      }

      apt::pin { 'dontblamenrpe':
        originator => 'LP-PPA-dontblamenrpe',
        priority   => '700',
        require    => [ Apt::Ppa['ppa:dontblamenrpe/ppa'], Exec['eyp-apt apt-get update'] ],
      }

      Package[$nrpe::params::package_name] {
        require => Apt::Pin['dontblamenrpe'],
      }

      Package[$nrpe::plugins_packages] {
        require => Apt::Pin['dontblamenrpe'],
      }
    }

    if($nrpe::params::include_epel)
    {
      include ::epel

      Package[$nrpe::params::package_name] {
        require => Class['::epel'],
      }

      Package[$nrpe::plugins_packages] {
        require => Class['::epel'],
      }
    }

    package { $nrpe::params::package_name:
      ensure => $nrpe::package_ensure,
    }

    if($nrpe::install_plugins)
    {
      package { $nrpe::plugins_packages:
        ensure => $nrpe::package_ensure,
      }
    }
  }

}

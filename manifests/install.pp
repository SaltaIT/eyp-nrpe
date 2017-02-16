class nrpe::install inherits nrpe {

  if($nrpe::manage_package)
  {
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

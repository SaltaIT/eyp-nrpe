class nrpe::install inherits nrpe {

  if($nrpe::manage_package)
  {
    if($nrpe::params::include_epel)
    {
      include ::epel
    }

    package { $nrpe::params::package_name:
      ensure => $nrpe::package_ensure,
    }

    if($nrpe::install_plugins)
    {
      package { $nrpe::params::plugins_package_name:
        ensure => $nrpe::package_ensure,
      }
    }
  }

}

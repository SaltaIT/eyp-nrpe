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
  }

}

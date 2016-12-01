class nrpe::install inherits nrpe {

  if($nrpe::manage_package)
  {
    package { $nrpe::params::package_name:
      ensure => $nrpe::package_ensure,
    }
  }

}

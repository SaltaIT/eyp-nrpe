class nrpe::service inherits nrpe {

  #
  validate_bool($nrpe::manage_docker_service)
  validate_bool($nrpe::manage_service)
  validate_bool($nrpe::service_enable)

  validate_re($nrpe::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${nrpe::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $nrpe::manage_docker_service)
  {
    if($nrpe::manage_service)
    {
      service { $nrpe::params::service_name:
        ensure => $nrpe::service_ensure,
        enable => $nrpe::service_enable,
      }
    }
  }
}

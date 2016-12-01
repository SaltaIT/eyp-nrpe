class nrpe(
                            $manage_package                  = true,
                            $package_ensure                  = 'installed',
                            $manage_service                  = true,
                            $manage_docker_service           = true,
                            $service_ensure                  = 'running',
                            $service_enable                  = true,
                            $dont_blame_nrpe                 = false,
                            $allow_bash_command_substitution = false,
                            $debug                           = false,
                            $command_timeout                 = '60',
                            $connection_timeout              = '300',
                            $allow_weak_random_seed          = false,
                            $install_plugins                 = true,
                          ) inherits nrpe::params{

  validate_re($package_ensure, [ '^present$', '^installed$', '^absent$', '^purged$', '^held$', '^latest$' ], 'Not a supported package_ensure: present/absent/purged/held/latest')

  class { '::nrpe::install': } ->
  class { '::nrpe::config': } ~>
  class { '::nrpe::service': } ->
  Class['::nrpe']

}

#
# nrpe.cfg concat
#
# 00 base
# 50 command base
# 51 command
# 90 include base
# 99 include
#
class nrpe(
                            $manage_package                  = true,
                            $package_ensure                  = 'installed',
                            $manage_service                  = true,
                            $manage_docker_service           = true,
                            $service_ensure                  = 'running',
                            $service_enable                  = true,
                            # nrpe variables
                            $dont_blame_nrpe                 = false,
                            $allow_bash_command_substitution = false,
                            $debug                           = false,
                            $command_timeout                 = '60',
                            $connection_timeout              = '300',
                            $allow_weak_random_seed          = false,
                            $install_plugins                 = true,
                            $allowed_hosts                   = [ '127.0.0.1' ],
                            $command_prefix                  = undef,
                            $nrped_purge                     = true,
                            $nrped_recurse                   = true,
                            $server_address                  = undef,
                            $server_port                     = '5666',
                          ) inherits nrpe::params{

  validate_re($package_ensure, [ '^present$', '^installed$', '^absent$', '^purged$', '^held$', '^latest$' ], 'Not a supported package_ensure: present/absent/purged/held/latest')

  class { '::nrpe::install': } ->
  class { '::nrpe::config': } ~>
  class { '::nrpe::service': } ->
  Class['::nrpe']

}

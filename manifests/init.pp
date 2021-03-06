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
            $manage_selinux_booleans         = true,
            $manage_package                  = true,
            $package_ensure                  = 'installed',
            $manage_service                  = true,
            $manage_docker_service           = true,
            $service_ensure                  = 'running',
            $service_enable                  = true,
            #extra packages
            $plugins_packages                = $nrpe::params::plugins_packages_default,
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
            $nrpe_conf_purge                 = true,
            $nrpe_conf_recurse               = true,
            $server_address                  = undef,
            $server_port                     = '5666',
            $username                        = $nrpe::params::username_default,
            $group                           = $nrpe::params::group_default,
            $nrpe_user_secondary_groups      = undef,
            $nrpe_conf_dir                   = $nrpe::params::nrpe_conf_dir_default,
            $selinux_dir                     = '/usr/local/src/selinux/nrpe',
            $pid_dir                         = $nrpe::params::pid_dir_default,
            $pid_dir_mode                    = undef,
            $nagios_home                     = $nrpe::params::nagios_home_default,
            $nagios_home_mode                = $nrpe::params::nagios_home_mode_default,
            $nagios_home_user                = $nrpe::params::nagios_home_user_default,
            $nagios_home_group               = $nrpe::params::nagios_home_group_default,
          ) inherits nrpe::params{

  $pid_file = "${pid_dir}/nrpe.pid"

  class { '::nrpe::install': } ->
  class { '::nrpe::config': } ~>
  class { '::nrpe::service': } ->
  Class['::nrpe']

}

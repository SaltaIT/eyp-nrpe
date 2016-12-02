define nrpe::command(
                      $command,
                      $commandname = $name,
                      $comment     = undef,
                    ) {

  # command[check_plugin_custom]=$ARG1$

  concat::fragment { "nrpe.cfg command ${command}":
    target  => $nrpe::params::nrpe_conf,
    order   => '51',
    content => template("${module_name}/command.erb")
  }

}

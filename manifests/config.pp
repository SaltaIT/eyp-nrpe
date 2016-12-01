class nrpe::config inherits nrpe {

  file { $nrpe::params::nrpe_conf:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/nrpecfg.erb"),
  }

  file { $nrpe::params::nrpe_conf_dir:
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => $nrpe::nrped_recurse,
    purge   => $nrpe::nrped_purge,
  }

}

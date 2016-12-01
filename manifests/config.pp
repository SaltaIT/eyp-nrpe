class nrpe::config inherits nrpe {

  concat { $nrpe::params::nrpe_conf:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  concat::fragment { 'nrpe.cfg base':
    target  => $nrpe::params::nrpe_conf,
    order   => '00',
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

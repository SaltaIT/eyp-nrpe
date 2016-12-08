class nrpe::config inherits nrpe {

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  concat { $nrpe::params::nrpe_conf:
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  concat::fragment { 'nrpe.cfg base':
    target  => $nrpe::params::nrpe_conf,
    order   => '00',
    content => template("${module_name}/nrpecfg.erb"),
  }

  concat::fragment { 'nrpe.cfg command base':
    target  => $nrpe::params::nrpe_conf,
    order   => '50',
    content => template("${module_name}/command_base.erb"),
  }

  concat::fragment { 'nrpe.cfg include base':
    target  => $nrpe::params::nrpe_conf,
    order   => '90',
    content => template("${module_name}/include_base.erb"),
  }

  exec { "mkdir p nrpe ${nrpe::params::nrpe_conf_dir}":
    command => "mkdir -p ${nrpe::params::nrpe_conf_dir}",
    creates => $nrpe::params::nrpe_conf_dir,
  }

  file { $nrpe::params::nrpe_conf_dir:
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => $nrpe::nrped_recurse,
    purge   => $nrpe::nrped_purge,
    require => Exec["mkdir p nrpe ${nrpe::params::nrpe_conf_dir}"],
  }

}

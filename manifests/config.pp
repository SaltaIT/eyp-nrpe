class nrpe::config inherits nrpe {

  file { $nrpe::params::nrpe_conf:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/nrpecfg.erb"),
  }

}

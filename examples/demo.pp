class { '::nrpe':
  dont_blame_nrpe   => true,
  allowed_hosts     => [ '1.2.3.4', '1.1.1.1' ],
  nrpe_conf_dir     => '/etc/nagios/nrpe.d/',
  nrpe_conf_purge   => false,
  nrpe_conf_recurse => true,
}

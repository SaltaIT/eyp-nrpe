define nrpe::includedir (
                          $dir       = $name,
                          $createdir = true,
                          $owner     = 'root',
                          $group     = 'root',
                          $mode      = '0755',
                          $recurse   = false,
                          $purge     = false,
                        ) {
  #
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  validate_absolute_path($dir)

  if($createdir)
  {
    exec { "mkdir p nrpe ${dir}":
      command => "mkdir -p ${dir}",
      creates => $dir,
      require => Class['nrpe'],
    }

    file { $dir:
      ensure  => 'directory',
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      recurse => $recurse,
      purge   => $purge,
      require => Exec["mkdir p nrpe ${dir}"],
    }
  }

  concat::fragment { "nrpe.cfg includedir ${dir}":
    target  => $nrpe::params::nrpe_conf,
    order   => '99',
    content => "include_dir=${dir}\n",
  }

}

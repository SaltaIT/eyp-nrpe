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
  validate_absolute_path($dir)

  if($createdir)
  {
    file { $dir:
      ensure  => 'directory',
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      recurse => $recurse
      purge   => $purge,
    }
  }

  concat::fragment { "nrpe.cfg includedir ${dir}":
    target  => $nrpe::params::nrpe_conf,
    order   => '99',
    content => "include_dir=${dir}\n",
  }

}

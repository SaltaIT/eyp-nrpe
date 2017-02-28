# nrpe

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What nrpe affects](#what-nrpe-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with nrpe](#beginning-with-nrpe)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)
    * [TODO](#todo)
    * [Contributing](#contributing)

## Overview

NRPE setup and configuration

## Module Description

This module installs NRPE and manages it's configuration file

## Setup

### What nrpe affects

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute on the system it's installed on.
* This is a great place to stick any warnings.
* Can be in list or paragraph form.
* On **Ubuntu 16.04** installs PPA [dontblamenrpe](https://launchpad.net/~dontblamenrpe/+archive/ubuntu/ppa/+packages)

### Setup Requirements

This module requires pluginsync enabled

### Beginning with nrpe

```puppet
class { '::nrpe':
  dont_blame_nrpe   => true,
  allowed_hosts     => [ '1.2.3.4', '1.1.1.1' ],
  nrpe_conf_dir     => '/etc/nagios/nrpe.d/',
  nrpe_conf_purge   => false,
  nrpe_conf_recurse => true,
}
```

## Usage

```puppet
nrpe::command { 'check_plugin_custom':
  command => '$ARG1$',
}
```

## Reference

### classes

#### nrpe

 * **dont_blame_nrpe**: # This option determines whether or not the NRPE daemon will allow clients to specify arguments to commands that are executed. (default: false) - **WARNING**: On **Ubuntu 16.04** this option is **ignored** due to a [supposed security risk](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=756479)
 * **allow_bash_command_substitution** = false
 * **debug**                           = false
 * **command_timeout**                 = '60'
 * **connection_timeout**              = '300'
 * **allow_weak_random_seed**          = false
 * **install_plugins**                 = true
 * **allowed_hosts**                   = [ '127.0.0.1' ]
 * **command_prefix**                  = undef
 * **nrped_purge**                     = true
 * **nrped_recurse**                   = true
 * **server_address**                  = undef
 * **server_port**                     = '5666'
 * **username**                        = $nrpe::params::username_default,
 * **group**                           = $nrpe::params::group_default,
 * **nrpe_conf_dir**                   = $nrpe::params::nrpe_conf_dir_default,

### defines

#### nrpe::command

#### nrpe::includedir

## Limitations

Tested on:
* CentOS 5
* CentOS 6
* CentOS 7
* Ubuntu 14.04

## Development

We are pushing to have acceptance testing in place, so any new feature should
have some test to check both presence and absence of any feature

### TODO

* multi instance support
* enable/disable SSL support

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

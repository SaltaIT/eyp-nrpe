
_osfamily               = fact('osfamily')
_operatingsystem        = fact('operatingsystem')
_operatingsystemrelease = fact('operatingsystemrelease').to_f

case _osfamily
when 'RedHat'
  $exec_nrpe = '/usr/lib64/nagios/plugins/check_nrpe'

when 'Debian'
  $exec_nrpe = '/usr/lib/nagios/plugins/check_nrpe'

else
  $exec_nrpe = '-_-'

end

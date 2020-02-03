define nrpe::sudo (
                    $command,
                  ) {
  include ::sudoers
  include ::nrpe

  sudoers::sudo { "nrpe::sudo for ${command}":
    username        => $::nrpe::username,
    withoutpassword => true,
    description     => 'sudo for NRPE',
    command         => $command,
  }
}

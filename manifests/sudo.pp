define nrpe::sudo (
                    $command,
                    $description = $name,
                  ) {
  include ::sudoers
  include ::nrpe

  sudoers::sudo { "nrpe::sudo for ${command}":
    username        => $::nrpe::username,
    withoutpassword => true,
    description     => $description,
    command         => $command,
  }
}

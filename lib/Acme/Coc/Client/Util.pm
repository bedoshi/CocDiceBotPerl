package Acme::Coc::Client::Util;

sub is_command {
    my ($self, $command) = @_;
    
    ## TODO: this is for future improvement.
    return $self->is_str_command($command);
}

sub is_str_command {
    my ($self, $command) = @_;

    return $command =~ /^\/.*/;
}

sub get_command {
    my ($self, $command) = @_;
    
    return undef unless $command =~ /\/.*/;

    $command =~ /(\/)(.*)/;
    return $2;
}

1;

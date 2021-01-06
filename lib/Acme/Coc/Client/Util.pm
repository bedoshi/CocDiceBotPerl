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

sub validate_command {
    my ($self, $command) = @_;

    # valid command format is /\/[1-0]+d[1-9][0-9]*/
    # e.g. /1d100 /1d3 /2d10 /1d6 /10d10
    return $command =~ /\/[1-9][0-9]*d[1-9][0-9]*/; 
}

1;

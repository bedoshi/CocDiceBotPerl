package Client::Util;
use utf8;
use strict;

sub is_valid_dice {
    my ($self, $command) = @_;

    return $self->validate_command($command);
}

sub get_command {
    my ($self, $command) = @_;
    
    return 'skill' if $command =~ /\/skill/;
    return undef unless $command =~ /\/.*/;

    $command =~ /(\/)(.*)/;
    return $2;
}

sub validate_command {
    my ($self, $command) = @_;

    # valid command format is /\/[1-0]+d[1-9][0-9]*/
    # e.g. /1d100 /1d3 /2d10 /1d6 /10d10
    return $command =~ /\/[1-9][0-9]*d[1-9][0-9]*/ unless $command =~ /skill/;
}

sub format_result {
    my ($self, $command, $result) = @_;

    my $str = "result of $command...";
    for my $item (@{ $result->{dices} }) {
        $str .= "\n ・${item}";
    }
    $str .= "\n sum: " . $result->{sum};

    return $str;
}

1;

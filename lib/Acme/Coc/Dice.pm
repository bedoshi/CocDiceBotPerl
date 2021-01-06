package Acme::Coc::Dice;

sub role_1d3 {
    return int(rand(3)) + 1;
}

sub role_1d4 {
    return int(rand(4)) + 1;
}

sub role_1d6 {
    return int(rand(6)) + 1;
}

sub role_1d8 {
    return int(rand(8)) + 1;
}

sub role_1d10 {
    return int(rand(10)) + 1;
}

sub role_1d20 {
    return int(rand(20)) + 1;
}

sub role_1d100 {
    return int(rand(100)) + 1;
}

sub role_skill {
    return role_1d100;
}
sub role {
    my ($self, $command) = @_;

    # I want to integrate upper function into this.
    # mdn in $command can be separated to m/d/n, and m is the times of roling dice, n is the number of sided dice.
    
}

1;

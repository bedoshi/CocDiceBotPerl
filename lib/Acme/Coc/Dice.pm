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
    return int(rand(100)) + 1;
}

sub role {
    my ($self, $command) = @_;

    # MdN in $command can be separated to M/d/N, and M is the times of roling dice, N is the number of sided dice.
    return [ role_skill ] if $command =~ /skill/;

    $command =~ /(\/)([1-9][0-9]*)d([1-9][0-9]*)/;

    my $times = $2;
    my $sided_dice = $3;

    my $result = [];

    for (1..$times) {
        push @{ $result }, int(rand($sided_dice) + 1);
    }

    return $result;
}

1;

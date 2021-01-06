package Acme::Coc::Dice;
use utf8;
use strict;

use Carp qw/croak/;

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
    my $results = [];

    croak "ダイスを振る回数が多すぎます。現在は10回までに制限しています。(input: $times)" if $times > 10;

    for (1..$times) {
        push @{ $results }, int(rand($sided_dice) + 1);
    }

    return $results;
}

1;

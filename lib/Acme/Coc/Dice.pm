package Acme::Coc::Dice;
use utf8;
use strict;

use Carp qw/croak/;

sub role_skill {
    my ($self) = @_;

    return $self->role('/1d100');
}

sub role {
    my ($self, $command) = @_;

    # MdN in $command can be separated to M/d/N, and M is the times of roling dice, N is the number of sided dice.
    use Data::Dumper;
    print Dumper($command =~ /\/skill/);
    return $self->role_skill if $command =~ /\/skill/;

    $command =~ /(\/)([1-9][0-9]*)d([1-9][0-9]*)/;

    my $times = $2;
    my $sided_dice = $3;
    my $results = [];
    my $sum = 0;

    croak "ダイスを振る回数が多すぎます。現在は10回までに制限しています。(input: $times)" if $times > 10;

    for (1..$times) {
        my $rand_num = int(rand($sided_dice)) + 1;
        push @{ $results }, $rand_num;
        $sum += $rand_num;
    }

    my $role_result = {
        dices => $results,
        sum => $sum,
    };
    return $role_result;
}

1;

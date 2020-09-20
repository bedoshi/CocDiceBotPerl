use strict;
use warnings;
use utf8;

use Acme::Coc::Dice;

use Test2::V0;

my $target = 'Acme::Coc::Dice';

subtest '#role_1d3' => sub {
    for (1..100) {
        ok $target->role_1d3 >= 1;
        ok $target->role_1d3 <= 3;
    }
};

subtest '#role_1d4' => sub {
    for (1..100) {
        ok $target->role_1d4 >= 1;
        ok $target->role_1d4 <= 4;
    }
};

subtest '#role_1d6' => sub {
    for (1..100) {
        ok $target->role_1d6 >= 1;
        ok $target->role_1d6 <= 6;
    }
};

subtest '#role_1d10' => sub {
    for (1..100) {
        ok $target->role_1d10 >= 1;
        ok $target->role_1d10 <= 10;
    }
};

subtest '#role_1d20' => sub {
    for (1..100) {
        ok $target->role_1d20 >= 1;
        ok $target->role_1d20 <= 20;
    }
};

subtest '#role_1d100' => sub {
    for (1..100) {
        ok $target->role_1d100 >= 1;
        ok $target->role_1d100 <= 100;
    }
};

done_testing;


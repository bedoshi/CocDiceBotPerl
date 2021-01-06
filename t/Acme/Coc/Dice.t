use strict;
use warnings;
use utf8;

use Acme::Coc::Dice;

use Test2::V0;
use Module::Spy;

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

subtest '#role' => sub {
    my $spy_role_skill = spy_on($target, 'role_skill')->and_call_through;

    $spy_role_skill->calls_reset;
    my $result = $target->role('/1d100');
    is @{ $result }, 1;
    for my $item (@{ $result }) {
        ok $item >= 1 && $item <= 100, "1 <= result <= 100: $item";
        ok !$spy_role_skill->called, 'role_skill was not called';
    }

    $spy_role_skill->calls_reset;
    $result = $target->role('/10d10');
    is @{ $result }, 10;
    for my $item (@{ $result }) {
        ok $item >= 1 && $item <= 10, "1 <= result <= 10: $item";
        ok !$spy_role_skill->called, 'role_skill was not called';
    }

    $spy_role_skill->calls_reset;
    $result = $target->role('/skill');
    is @{ $result }, 1;
    for my $item (@{ $result }) {
        ok $item >= 1 && $item <= 100, "1 <= result <= 100: $item";
        ok $spy_role_skill, 'role_skill was called';
    }
};

done_testing;

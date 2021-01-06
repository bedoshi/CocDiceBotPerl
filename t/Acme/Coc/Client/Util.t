use strict;
use warnings;
use utf8;

use Acme::Coc::Client::Util;

use Test2::V0;
use Module::Spy;

my $target = 'Acme::Coc::Client::Util';

subtest '#is_str_command' => sub {
    ok !$target->is_str_command('hello_world');
    ok $target->is_str_command('/hello_world');
};

subtest '#is_command' => sub {
    my $spy = spy_on($target, 'validate_command')->and_call_through;

    $spy->calls_reset;
    ok !$target->is_command('hello_world');
    ok $spy->called;

    $spy->calls_reset;
    ok $target->is_command('/1d100');
    ok $spy->called;
};

subtest '#get_command' => sub {
    is $target->get_command('/hello_world'), 'hello_world';
    is $target->get_command('hello_world'), undef;
};


subtest 'validate_command' => sub {
    my $ok_pattern = ['/1d100', '/1d3', '/2d10', '/1d6', '/10d10'];
    my $ng_pattern = ['1d100', 'ad11', '12345', 'aaaaaa'];
    for my $item (@{ $ok_pattern }) {
        ok $target->validate_command($item), "ok pattern: $item";
    }
    for my $item (@{ $ng_pattern }) {
        ok !$target->validate_command($item), "ng pattern: $item";
    }
};

done_testing;

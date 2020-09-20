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

subtest '#is_valid_command' => sub {
    my $spy = spy_on($target, 'is_str_command')->and_call_through;

    $spy->calls_reset;
    ok !$target->is_valid_command('hello_world');
    ok $spy->called;

    $spy->calls_reset;
    ok $target->is_valid_command('/hello_world');
    ok $spy->called;
};

subtest '#get_command' => sub {
    is $target->get_command('/hello_world'), 'hello_world';
    is $target->get_command('hello_world'), undef;
};

done_testing;

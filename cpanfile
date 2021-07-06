requires 'LINE::Bot::API';
requires 'Plack';
requires 'Acme::CoC::Dice';

# for exception
requires 'Carp';
requires 'Try::Tiny';

# for test
on test => sub {
    requires 'Data::Dumper';
    requires 'Test::More';
    requires 'Test2::V0';
    requires 'Test2::Plugin::UTF8';
    requires 'Test::Deep';
    requires 'Module::Spy';
};
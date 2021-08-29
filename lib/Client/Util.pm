package Client::Util;
use utf8;
use strict;
use LINE::Bot::Audience;

my $channel_secret          = $ENV{CHANNEL_SECRET};
my $channel_access_token    = $ENV{CHANNEL_ACCESS_TOKEN};

my $audience = LINE::Bot::Audience->new(
    channel_secret       => $channel_secret,
    channel_access_token => $channel_access_token,
);

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
    return $command =~ /\/[1-9][0-9]*d[1-9][0-9]*/ ||
        $command =~ /\/skill/ ||
        $command =~ /\/make_audience/;
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

sub make_audience {
    my ($self, $command) = @_;
    $command =~ /make_audience (.*)\_(.*)/;
    my $audience_name = $1 // 'test audience';
    my $audience_id = $2;
    my $res = $audience->create_audience_for_uploading({
        description => $audience_name,
        audiences => [$2],
    });

    return $res->audienceGroupId if $res->audienceGroupId;
    return $res->message;
}

1;

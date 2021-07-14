package CocBot;
use utf8;
use strict;
use warnings;

use CoCBot::Util;

use LINE::Bot::API::Builder::SendMessage;

my $channel_secret          = $ENV{CHANNEL_SECRET};
my $channel_access_token    = $ENV{CHANNEL_ACCESS_TOKEN};

my $bot = LINE::Bot::API->new(
    channel_secret       => $channel_secret,
    channel_access_token => $channel_access_token,
);

sub dice_message {
    my ($self, $text) = @_;

    my $messages = LINE::Bot::API::Builder::SendMessage->new;
    if (CoCBot::Util->is_valid_dice($text)) {
        eval {
            my $results = Acme::CoC::Dice->role(CoCBot::Util->get_command($text));
            $messages->add_text( text => CoCBot::Util->format_result($text, $results));
        };

        if ($@) {
            $messages->add_text( text => "有効なダイスを入力してください（1d3, 1d4, 1d6, 1d8, 1d10, 1d100 or skill) \n error: $@");
        }
    }

    return $messages;
}

1;

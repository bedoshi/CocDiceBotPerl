# in the synopsis.psgi
use strict;
use utf8;
use warnings;
use LINE::Bot::API;
use LINE::Bot::API::Builder::SendMessage;
use Plack::Request;
use Data::Dumper;
use Acme::Coc::Dice;
use Acme::Coc::Client::Util;

my $channel_secret          = $ENV{CHANNEL_SECRET};
my $channel_access_token    = $ENV{CHANNEL_ACCESS_TOKEN};

my $bot = LINE::Bot::API->new(
    channel_secret       => $channel_secret,
    channel_access_token => $channel_access_token,
);

sub {
    my $req = Plack::Request->new(shift);
 
    unless ($req->method eq 'POST' && $req->path eq '/callback') {
        return [200, [], ['Not Found']];
    }
 
    unless ($bot->validate_signature($req->content, $req->header('X-Line-Signature'))) {
        return [200, [], ['failed to validate signature']];
    }

    my $events = $bot->parse_events_from_json($req->content);
    for my $event (@{ $events }) {
        next unless $event->is_message_event && $event->is_text_message;
        my $messages = LINE::Bot::API::Builder::SendMessage->new;

        if (Acme::Coc::Client::Util->is_valid_dice($event->text)) {

            my $command = 'role_'.Acme::Coc::Client::Util->get_command($event->text);

            eval {
                my $num = Acme::Coc::Dice->$command;
                $messages->add_text( text => "$command: $num");
            };

            if ($@) {
                $messages->add_text( text => '有効なダイスじゃない(1d3, 1d4, 1d6, 1d8, 1d10, 1d100 or skill');
            }
        } else {
            $messages->add_text( text => '有効なダイスじゃない(e.g. /skill /1d100 /1d6 /1d3 などで入力してね');
        }

        $bot->reply_message($event->reply_token, $messages->build);
    }
 
    return [200, [], ["OK"]];
};

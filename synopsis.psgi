# in the synopsis.psgi
use strict;
use utf8;
use warnings;
use LINE::Bot::API;
use LINE::Bot::API::Builder::SendMessage;
use Plack::Request;
use Data::Dumper;
use Acme::CoC::Dice;
use Client::Util;

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

        if (Client::Util->is_valid_dice($event->text)) {
            eval {
                my $results = Acme::CoC::Dice->role(Client::Util->get_command($event->text));
                $messages->add_text( text => Client::Util->format_result($event->text, $results));
            };

            if ($@) {
                $messages->add_text( text => "有効なダイスを入力してください（1d3, 1d4, 1d6, 1d8, 1d10, 1d100 or skill) \n error: $@");
            }
        }

        $bot->reply_message($event->reply_token, $messages->build);
    }
 
    return [200, [], ["OK"]];
};

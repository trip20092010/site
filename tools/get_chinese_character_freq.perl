use strict;
use warnings;

use LWP::UserAgent;

my $url = "http://en.wikipedia.org/w/index.php?title=List_of_Beijing_Subway_stations&printable=yes";

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';

my $char_freq = {};

my $res = &fetch_url($url);

if ($res->is_success) {
	foreach (split "", $res->decoded_content((charset => 'utf-8'))) {
		if (ord > 0x4e00) {
			$char_freq->{$_}++;
		}
	}
}
else {
	die "fail fetch $url: $res->status_line";
}



foreach my $char (sort { $char_freq->{$b} <=> $char_freq->{$a} } keys %{$char_freq}) {
	print $char, "\t", $char_freq->{$char}, "\n";
}


sub fetch_url
{
	my $url = shift;
	my $ua = LWP::UserAgent->new;
	my $req = HTTP::Request->new(GET => $url);
	return $ua->request($req);
}

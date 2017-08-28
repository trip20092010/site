use strict;
use warnings;

# BUG: this is an ugly hack, at least use a JSON parser

# Usage:
# cat ../kml/selected/four_continents.kml | perl kml_to_placenames.perl

use LWP::UserAgent;

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';

my $char_freq = {};


while (<STDIN>) {

	next if ! /^\s*[0-9]/;
	s/\s*//g;
	my ($lng, $lat, $time) = split ",";

	#print "--> ", $lng, "\t", $lat, "\n";
	
	my $json = &get_json($lng, $lat);
	my ($subdiv, $country) = &get_placenames($json);
	print $subdiv, "\t", $country, "\n";
}


sub get_json
{
	my $lng = shift;
	my $lat = shift;

	my $url = "http://ws.geonames.org/countrySubdivisionJSON?formatted=true&lat=$lat&lng=$lng&style=full";

	#print "--> $url\n";

	my $res = &fetch_url($url);

	if ($res->is_success) {
		return $res->decoded_content((charset => 'utf-8'));
	}
	else {
		warn "fail fetch $url: $res->status_line";
		return "ERROR";
	}
}


sub get_placenames
{
	my $json = shift;

	my $adminName1 = "UNDEF";
	my $countryCode = "UNDEF";

	my @lines = split "\n", $json;

	foreach (@lines) {
		#print "--> $_\n";
		if (/adminName1/) {
			(undef, $adminName1) = split ":";
		}
		if (/countryCode/) {
			(undef, $countryCode) = split ":";
		}
	}
	return ($adminName1, $countryCode);
}


sub fetch_url
{
	my $url = shift;
	my $ua = LWP::UserAgent->new;
	my $req = HTTP::Request->new(GET => $url);
	return $ua->request($req);
}

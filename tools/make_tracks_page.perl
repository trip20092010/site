use strict;
use warnings;

# Mapping country names (as they are written in the tracks-file)
# to the ISO country codes (which are expected by the Google Charts API).
# The ISO 2-letter codes are available here:
# http://www.iso.org/iso/english_country_names_and_code_elements
# BUG: move this into an independent library
my $name_to_code = {
	"Argentina" => "ar",
	"Australia" => "au",
	"Bolivia" => "bo",
	"Botswana" => "bw",
	"Brazil" => "br",
	"Cambodia" => "kh",
	"Chile" => "cl",
	"China" => "cn",
	"Rapa Nui, Chile" => "cl",
	"Ecuador" => "ec",
	"French Polynesia, France" => "fr", # BUG: pf does not have a flag
	"Hong Kong" => "hk",
	"India" => "in",
	"Indonesia" => "id",
	"Kenya" => "ke",
	"Laos" => "la",
	"Macau" => "mo",
	"Malawi" => "mw",
	"Malaysia" => "my",
	"Namibia" => "na",
	"New Zealand" => "nz",
	"Papua New Guinea" => "pg", # BUG: pg does not have a flag
	"Peru" => "pe",
	"Rwanda" => "rw",
	"South Africa" => "za",
	"Tanzania" => "tz",
	"Thailand" => "th",
	"Uganda" => "ug",
	"United Kingdom" => "uk", # BUG: ISO requires "GB", Google Charts requires "UK"
	"Vietnam" => "vn",
	"Zambia" => "zm",
};

while (<STDIN>) {

	if (/^<h3>(.*)<\/h3>$/) {
		&format_country_line($1);
	}
	elsif (/^([0-9][0-9][0-9][0-9])([0-9][0-9])([0-9][0-9])\t(.*)$/) {
		chomp;
		my $date = $1 . $2 . $3;
		my $date_pp = $1 . "-" . $2 . "-" . $3;
		my $desc = $4;
		foreach ($desc) {
			s/-([^> -]+)->/&rarr;<sup>$1<\/sup>/g;
			s/->/&rarr;/g;
		}
		if ($desc =~ /\[No recording\]/) {
			&format_plain_line($date, $date_pp, $desc);
		}
		else {
			&format_line($date, $date_pp, $desc);
		}
	}
	else {
		print;
	}
}

sub format_country_line
{
	my $country_str = shift;

	my $country = $country_str;
	$country =~ s/ \(.*//;

	my $code = &get_country_code($country);

print <<COUNTRYLINE;
<h3><img src="http://chart.apis.google.com/chart?chst=d_simple_text_icon_right&amp;chld=|20|FFF|flag_$code|24|000|F00" alt="[]" title="Flag of $country"/>&nbsp;$country_str</h3>
COUNTRYLINE
#print <<COUNTRYLINE;
#<h3>$country_str</h3>
#COUNTRYLINE
}


sub get_country_code
{
	my $name = shift;
	if (defined $name_to_code->{$name}) {
		return $name_to_code->{$name};
	}
	else {
		return "";
	}
}


sub format_plain_line
{
	my $date = shift;
	my $date_pp = shift;
	my $desc = shift;

print <<PLAINLINE;
<li>$date_pp $desc</li>
PLAINLINE
}


sub format_line
{
	my $date = shift;
	my $date_pp = shift;
	my $desc = shift;

print <<GPSLINE;
<li>$date_pp
(<a href="kml/$date.kml">kml</a>,
<a href="http://maps.google.com/maps?q=http://files.dropbox.com/u/1397729/trip2009/kml/$date.kml">map</a>)
&nbsp;$desc</li>
GPSLINE
}

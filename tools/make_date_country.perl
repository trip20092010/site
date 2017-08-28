use strict;
use warnings;
use Storable;

my $dates_storable = "storable/dates.storable";

my $current_country = "BUG";
my $dates = {};

while (<STDIN>) {
	if (m{^<h3>(.*) \(.*</h3>$}) {
		$current_country = $1;
	}

	if (m{^([0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9])\t.*}) {
		$dates->{$1} = $current_country;
	}
}

foreach my $date (keys %{$dates}) {
	print $date, "\t", $dates->{$date}, "\n";
}

store $dates, $dates_storable;

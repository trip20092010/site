
# Usage:
# bash gpx_to_csv_all.bash | perl equator.perl

use strict;
use warnings;

my $oldsign = undef;

while (<STDIN>) {
	chomp;

	if (/^\s*([\.0-9-]+)\s*,\s*([\.0-9-]+)\s*,\s*([\.0-9-]+)\s*,\s*(\S+)\s*$/) {
		if (! defined $oldsign) {
			$oldsign = ($2 > 0);
		}
		elsif ($oldsign != ($2 > 0)) {
			$oldsign = ($2 > 0);
			print $1, " ", $3, " ", $4, "\n";
		}
	}
}

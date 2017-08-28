# GPX merger (just a front end to gpsbabel)
# There is probably a better way to do this.
# The filenames are expected to be in STDIN.

# Author: Kaarel Kaljurand
# Version: 2009-11-03

use strict;
use warnings;

my @track_str = ();

foreach (<STDIN>) {
	chomp;
	push @track_str, "-f", $_;
}

warn "Processing: ", (join ' ', @track_str), "\n";

exec "gpsbabel", "-i", "gpx", @track_str, "-o", "gpx,gpxver=1.1", "-F", "-";

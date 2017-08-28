use strict;
use warnings;

while (<STDIN>) {

	my @vehicles = m/-([^> -]+)->/;
	foreach my $v (@vehicles) {
		print $v, "\n";
	}
}

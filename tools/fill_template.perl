use strict;
use warnings;

while (<STDIN>) {
	if (/^CMD: (.*)/) {
		my $cmd = $1;
		foreach ($cmd) {
			chomp;
			s/^\s+//;
			s/s+$//;
		}

		#print "<!-- CMD: $cmd -->\n";
		print STDERR "CMD: $cmd\n";
		system $cmd;
	}
	else {
		print;
	}
}

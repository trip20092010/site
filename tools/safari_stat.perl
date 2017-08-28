
use strict;
use warnings;

my $h = {};

while (<STDIN>) {
	chomp;

	if (m{<li>(.*)</li>}) {
		my $name = lc $1;
		foreach ($name) {
			s/\(.*//;
			s/\[.*//;
			s/^\s+//;
			s/\s+$//;
		}
		$h->{$name}++;
	}
	else {
		# warn "Ignoring: $_\n";
	}
}

print "<table>\n";
print "<thead>\n";
print "<tr><td>Animal</td><td>Freq</td></tr>\n";
print "</thead>\n";
print "<tbody>\n";
foreach my $k (sort { $h->{$b} cmp $h->{$a} } keys %{$h}) {
	print "<tr><td>", $k, "</td><td>", $h->{$k}, "</td></tr>\n";
}
print "</tbody>\n";
print "</table>\n";

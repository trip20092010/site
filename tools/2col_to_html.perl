use strict;
use warnings;

&make_header();
while (<STDIN>) {
	chomp;

	my ($c1, $c2, $c3) = split /\s+/;

	#print "<li><code>", $c1, "</code>&nbsp;&nbsp;", &format_link($c3), "</li>";
	print $c1, "   ", &format_link($c3), "\n";
}
&make_footer();

sub format_link
{
	my $link = shift;
	return "<a href='$link'>$link</a>";
}

sub make_header
{
print <<EOF;
<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title>Links to stories ordered by modification time</title>

<style type="text/css">
pre {
	font-family: monospace
}
</style>
</head>

<body>
<pre>
EOF
}


sub make_footer
{
print <<EOF;
</pre>
<hr/>
</body>
</html>
EOF
}

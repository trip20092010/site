#!/usr/bin/python2.5

# Usage:
# cat ../data/picasaweb_trip20092010.csv | python tsv_to_html.py > ../general/picasaweb_trip20092010.html

# TODO: rewrite to look nice in Python
# TODO: understand how the timezone info is handled

import sys
from time import gmtime, strftime

def myescape(str):
	"""
	HTML-escapes ampersands and less-than signs in the given string,
	and returns the modified string.
	BUG: use instead a library function
	"""
	return str.replace('&', '&amp;').replace('<', '&lt;')


def nice_date(time):
	"""
	BUG: rewrite
	"""
	ptime = gmtime(int(time) / 1000)
	return strftime("%Y-%m-%d", ptime)

def nice_time(time):
	"""
	BUG: rewrite
	"""
	ptime = gmtime(int(time) / 1000)
	return strftime("%H:%M:%S", ptime)

# Main
print '''<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta property="dc:creator" content="Kaarel Kaljurand"/>
<meta property="dc:language" content="EN"/>

<script type="text/javascript" src="../../js/jquery.min.js"></script>
<script type="text/javascript" src="../../js/jquery.tablesorter.min.js"></script>
<script type="text/javascript">$(document).ready(function() 
	{ 
		$("table").tablesorter(); 
	} 
);</script>

<link rel="stylesheet" title="default" href="../css/main.css" media="screen" type="text/css"/>

<title>Photos</title>
</head>

<body>
<div style="font-size: 90%">
<p>This table lists (and links to) all the photos in
<a href="http://picasaweb.google.com/trip20092010">http://picasaweb.google.com/trip20092010</a>,
showing their album title, title, time of capture, and description.</p>

<p>This table is sortable. Click on a column header to sort by this
column, click again to change the sorting direction. For multi-column
sorting, hold down the SHIFT-key while clicking on an additional column.
Note that the time of the day is in a separate column
from the day of the year. This enables grouping together photos
of sunrises, (late night) parties, and other such events that tend to
happen always at the same time of day.</p>

<p>Because this is a large table, sorting can take several seconds, depending on
the speed of your browser and your computer.</p>
</div>

<table>
<thead>
<tr>
<th title="Name of the album">Album</th>
<th title="Title of the photo linked to the actual image file">Title</th>
<th title="The day of the year">Day</th>
<th title="The time of the day">Time</th>
<th title="Photo caption">Description</th>
</tr>
</thead>
<tbody>'''

for line in sys.stdin:
	f = line.strip().split('\t')

	# If the field of caption/description is missing, then
	# we create it, but any other violation is a syntax error.
	if len(f) == 4:
		f.append("")

	if len(f) == 5:
		print '<tr>'
		print '<td>' + myescape(f[0]) + '</td>'
		print '<td><a href="' + myescape(f[1]) + '">' + myescape(f[3]) + '</a></td>'
		print '<td>' + nice_date(f[2]) + '</td>'
		print '<td>' + nice_time(f[2]) + '</td>'
		print '<td>' + myescape(f[4]) + '</td>'
		print '</tr>'
	else:
		print >> sys.stderr, 'Syntax error: %s' % line

print '''</tbody>
</table>
</body>
</html>'''

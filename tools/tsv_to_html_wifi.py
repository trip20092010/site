#!/usr/bin/python2.5

# Usage:
# cat ../data/wireless_connections.csv | python tsv_to_html_wifi.py > ../general/wireless_connections.html

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


def nice_datetime(time):
	"""
	BUG: rewrite
	"""
	ptime = gmtime(int(time))
	return strftime("%Y-%m-%d", ptime)
#return strftime("%Y-%m-%d %H:%M:%S", ptime)


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

<title>Wireless connections</title>
</head>

<body>
<div style="font-size: 90%">
<p>List of wireless networks that we connected to during the trip. Each network is listed
together with the last time the connection was made.
Note that successfully making a connection does not necessarily mean that we were
able to use internet in this network.</p>
</div>

<table>
<thead>
<tr>
<th title="Last connected">Last connected</th>
<th title="Name">Name</th>
</tr>
</thead>
<tbody>'''

first_day = 1248247025
last_day = 1285509347
i = 0

for line in sys.stdin:
	f = line.strip().split('\t')

	if len(f) == 2:
		if int(f[0]) >= first_day and int(f[0]) <= last_day:
			i = i + 1
			print '<tr>'
			print '<td>' + nice_datetime(f[0]) + '</td>'
			print '<td>' + f[1] + '</td>'
			print '</tr>'
		else:
			print >> sys.stderr, 'Out of range: %s' % line
	else:
		print >> sys.stderr, 'Syntax error: %s' % line

print '''</tbody>
</table>'''
print '<p>Number of wifi networks: %s</p>' % i
print '''</body>
</html>'''

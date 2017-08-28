#!/usr/bin/python2.5

# Usage:
# python get_videos_as_tsv.py | python youtube_tsv_to_html.py > ../general/videos.html


import sys

def myescape(str):
	"""
	HTML-escapes ampersands and less-than signs in the given string,
	and returns the modified string.
	BUG: use instead a library function
	"""
	return str.replace('&', '&amp;').replace('<', '&lt;')

# Main
print '''<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta property="dc:creator" content="Kaarel Kaljurand"/>
<meta property="dc:language" content="EN"/>

<script type="text/javascript" src="../../js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="../../js/jquery.tablesorter.min.js"></script>
<script type="text/javascript">$(document).ready(function() 
	{ 
		$("table").tablesorter(); 
	} 
);</script>

<link rel="stylesheet" title="default" href="../css/main.css" media="screen" type="text/css"/>

<title>Videos</title>
</head>

<body>
<table>
<thead>
<tr>
<th title="ID of the video linked to the actual video page">ID</th>
<th title="Title and description of the video">Title and Description</th>
<th title="Tags of the video">Tags</th>
<th title="Length of the video in seconds">Length</th>
<th title="Number of times the video has been viewed on YouTube">Views</th>
</tr>
</thead>
<tbody>'''

lines = 0

for line in sys.stdin:
	f = line.strip().split('\t')
	if len(f) == 7:
		lines = lines + 1
		print '<tr>'
		print '<td><a href="' + myescape(f[2]) + '">' + myescape(f[0]) + '</a></td>'
		print '<td><b>' + myescape(f[1]) + '</b> ' + myescape(f[3]) + '</td>'
		print '<td>' + myescape(f[4]) + '</td>'
		print '<td>' + myescape(f[5]) + '</td>'
		print '<td>' + myescape(f[6]) + '</td>'
		print '</tr>'

print '''</tbody>
</table>
<p>Video count: '''
print lines
print '''</p></body>
</html>'''

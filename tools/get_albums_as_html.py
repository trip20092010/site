#!/usr/bin/python2.5
# This Python file uses the following encoding: utf-8

# Usage:
# python get_albums_as_html.py > ../general/photo_albums.html

import gdata.photos.service
import gdata.media
import gdata.geo

album_order = [
'Machame',
#'People of Africa',
#'Animals of Africa',
'São Paulo',
'Rio de Janeiro',
'Ouro Preto',
'Salvador',
'Recife/Olinda',
'Lençóis Maranhenses',
'São Luís',
'Amazonas',
'Iquitos',
'Quito',
'Quilotoa',
'Baños',
'Galapagos',
'Nazca',
'Colca Canyon',
'El Misti',
'Lake Titicaca',
'La Paz',
'Huayna Potosi',
'Potosi',
'Salar de Uyuni',
'San Pedro de Atacama',
'Valparaiso',
'Mendoza',
'Patagonian ferryride',
'Torres del Paine',
'Perito Moreno',
'Tierra del Fuego',
'Buenos Aires',
'Pantanal',
'Rapa Nui',
'French Polynesia',
'Sydney',
'Papua New Guinea',
'Jakarta',
'Yogyakarta',
'Bromo',
'Berastagi',
'Bukit Lawang',
'Medan',
'Penang',
'Thale Noi',
'Bangkok',
'Chiang Mai',
'Vieng Phouka',
'Mekong river journey (Laos)',
'Luang Prabang',
'Hoi An',
'Nha Trang',
'Dalat',
'Mekong Delta',
'Angkor',
'Mumbai',
'Ahmedabad',
'Hong Kong',
'Macau',
]


def myescape(str):
	"""
	HTML-escapes ampersands and less-than signs in the given string,
	and returns the modified string.
	BUG: use instead a library function
	"""
	if str is not None:
		return str.replace('&', '&amp;').replace('<', '&lt;')
	else:
		return ""


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

<style type="text/css">
table {
	margin: 0;
	margin-top: 1em;
	border: none;
}
thead, tbody, tr, td {
	border: none;
}
a, img {
	border: none;
}
</style>


<title>Photo albums</title>
</head>

<body>
<div style="font-size: 90%">
<p>This table lists all the albums in
<a href="http://picasaweb.google.com/trip20092010">http://picasaweb.google.com/trip20092010</a>,
showing their title, description, rank in temporal order, and photo count.
The thumbnail is linked to the content of the album.</p>
</div>

<table>
<col/>
<col/>
<col/>
<col style="width: 6em; text-align: right"/>
<thead>
<tr>
<th title="Rank in the temporal order">#</th>
<th title="Album title and thumbnail linked to the album content">Title</th>
<th title="Album description">Description</th>
<th title="Number of photos in the album">Photo count</th>
</tr>
</thead>
<tbody>'''

gd_client = gdata.photos.service.PhotosService()

albums = gd_client.GetUserFeed(user='trip20092010')
for album in albums.entry:
	print '<tr>'
	print '<td>' + str(album_order.index(album.title.text) + 1) + '</td>'
	print '<td><b>' + myescape(album.title.text) + '</b><br/><br/><a href="' + album.GetHtmlLink().href + '"><img src="' + album.media.thumbnail[0].url + '"/></a></td>'
	print '<td>' + myescape(album.summary.text) + '</td>'
	print '<td>' + album.numphotos.text + '</td>'
	print '</tr>'

print '''</tbody>
</table>
</body>
</html>'''

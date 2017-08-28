#!/usr/bin/python2.5

import sys
from collections import defaultdict

import gdata.photos.service
import gdata.media
import gdata.geo

summaries = defaultdict(str)

# Create photo_title -> photo_summary mapping from a flat file
fn = sys.argv[1];
album_title = ""
for l in open(fn):
	fields = l.strip().split('\t')
	if len(fields) == 1:
		album_title = fields[0].strip()
	elif len(fields) == 2:
		if fields[1] != 'None':
			photo_title = fields[0].strip()
			#print 'Adding: [', photo_title, '] -> ', fields[1]
			summaries[album_title + photo_title] = fields[1].strip()

gd_client = gdata.photos.service.PhotosService()
gd_client.email = 'trip20092010@gmail.com'
gd_client.password = 'jura'
#gd_client.source = 'api-sample-google-com'
gd_client.ProgrammaticLogin()

albums = gd_client.GetUserFeed()
change_counter = 0
for album in albums.entry:
	album_title2 = 'Album: %s (%s)' % (album.title.text, album.numphotos.text)
	print album_title2

	photos = gd_client.GetFeed('/data/feed/api/user/default/albumid/%s?kind=photo' % (album.gphoto_id.text))
	for photo in photos.entry:
		if (album_title2 + photo.title.text) in summaries:
			new_summary = summaries[album_title2 + photo.title.text]
			# BUG: add: if summary is None then also update the summary
			if (photo.summary.text is not None) and (photo.summary.text != new_summary):
				change_counter += 1
				print '  Photo: [', photo.title.text, ']'
				print '    Old summary: ', photo.summary.text
				print '    New summary: ', new_summary
				photo.summary.text = new_summary
				photo = gd_client.UpdatePhotoMetadata(photo)

print 'Number of summaries changed: ', change_counter

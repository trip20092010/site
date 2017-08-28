#!/usr/bin/python2.5

import gdata.photos.service
import gdata.media
import gdata.geo

gd_client = gdata.photos.service.PhotosService()

albums = gd_client.GetUserFeed(user='trip20092010')
for album in albums.entry:
	photos = gd_client.GetFeed('/data/feed/api/user/trip20092010/albumid/%s?kind=photo' % (album.gphoto_id.text))
	for photo in photos.entry:
		summary = ""
		if photo.summary.text:
			summary = photo.summary.text
		print album.title.text, '\t', photo.content.src, '\t', photo.exif.time.text, '\t', photo.title.text, '\t', summary

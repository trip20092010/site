#!/usr/bin/python2.5

import gdata.photos.service
import gdata.media
import gdata.geo

gd_client = gdata.photos.service.PhotosService()
gd_client.source = 'api-sample-google-com'

albums = gd_client.GetUserFeed(user='trip20092010')
for album in albums.entry:
	print 'Album: %s (%s)' % (album.title.text, album.numphotos.text)

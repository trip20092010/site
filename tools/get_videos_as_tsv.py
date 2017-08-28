#!/usr/bin/python2.5

# Usage:
#
# python get_videos_as_tsv.py > ../data/videos.csv 

# TODO: some descriptions (those that contain HTML) don't make it as a whole (see Samburu desc)

import sys
import gdata.youtube.service

def PrintEntryAsTsv(entry):
	description_text = ""
	if entry.media.description is not None and entry.media.description.text is not None:
		description_text = entry.media.description.text

	view_count = 0
	if entry.statistics is not None:
		view_count = entry.statistics.view_count

	id_and_title = entry.media.title.text.partition(' ')

	if entry.media.keywords.text is not None and entry.media.keywords.text.find("googlevideo") == -1:
		print '%s\t%s\t%s\t%s\t%s\t%s\t%s' % (id_and_title[0], id_and_title[2], entry.media.player.url, description_text, entry.media.keywords.text, entry.media.duration.seconds, view_count)


def PrintEntryDetails(entry):
	print 'Video title: %s' % entry.media.title.text
	#print 'Video published on: %s ' % entry.published.text
	print 'Video description: %s' % entry.media.description.text
	#print 'Video category: %s' % entry.media.category[0].text
	print 'Video tags: %s' % entry.media.keywords.text
	print 'Video watch page: %s' % entry.media.player.url
	#print 'Video flash player URL: %s' % entry.GetSwfUrl()
	print 'Video duration: %s' % entry.media.duration.seconds

	# non entry.media attributes
	#print 'Video geo location: %s' % entry.geo.location()
	print 'Video view count: %s' % entry.statistics.view_count
	#print 'Video rating: %s' % entry.rating.average

	# show alternate formats
	#for alternate_format in entry.media.content:
	#	if 'isDefault' not in alternate_format.extension_attributes:
	#		print 'Alternate format: %s | url: %s ' % (alternate_format.type, alternate_format.url)

	# show thumbnails
	#for thumbnail in entry.media.thumbnail:
	#	print 'Thumbnail url: %s' % thumbnail.url


def PrintVideoFeed(feed):
	count = 0
	for entry in feed.entry:
		PrintEntryAsTsv(entry)
		count = count + 1
	return count


def SearchByAuthor(author, start_index, max_results):
	yt_service = gdata.youtube.service.YouTubeService()
	query = gdata.youtube.service.YouTubeVideoQuery()
	query.author = author
	#query.orderby = 'viewCount'
	query.racy = 'include'
	query.start_index = start_index
	query.max_results = max_results
	return yt_service.YouTubeQuery(query)
	


step = 20
video_count = 0;

print >> sys.stderr, 'Fetching nairobicapetown'
for i in range(1, 80, step):
	feed = SearchByAuthor('nairobicapetown', i, step)
	lines_printed = PrintVideoFeed(feed)
	video_count = video_count + lines_printed
	print >> sys.stderr, video_count

print >> sys.stderr, 'Fetching trip20092010'
for i in range(1, 340, step):
	feed = SearchByAuthor('trip20092010', i, step)
	lines_printed = PrintVideoFeed(feed)
	video_count = video_count + lines_printed
	print >> sys.stderr, video_count

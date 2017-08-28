
for gpxfile in $(ls ~/Dropbox/Other/GPX/*.gpx)
do
	xsltproc gpx_to_csv.xslt $gpxfile
done

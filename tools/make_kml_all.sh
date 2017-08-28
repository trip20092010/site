
gpxdir=../../../Other/GPX/
kmldir=../kml/

for gpxfile in $(ls $gpxdir/20*.gpx)
do
	kmlfile=$kmldir/`basename $gpxfile .gpx`.kml
	echo "Generating $gpxfile -> $kmlfile"
	xsltproc remove_activelog.xslt $gpxfile > /tmp/tmp.gpx
	gpsbabel -i gpx -o 'kml,trackdata=1,points=0,line_color=990000ff,labels=0,units=m' -f /tmp/tmp.gpx -F $kmlfile
done

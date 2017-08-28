
gpx=../../../Other/GPX/
kml=../kml/

for i in '20100926'
do
	echo "Generating $i"
	xsltproc remove_activelog.xslt $gpx/$i.gpx > /tmp/$i.gpx
	gpsbabel -i gpx -o 'kml,trackdata=1,points=0,line_color=990000ff,labels=0,units=m' -f /tmp/$i.gpx -F $kml/$i.kml
done

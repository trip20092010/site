mytmp1="/tmp/merged1.gpx"
mytmp2="/tmp/merged2.gpx"

echo "Processing $1"

echo "Merging tracks..."
cat $1.flist | perl gpx_merger.perl > $mytmp1

echo "Removing ACTIVELOGs"
xsltproc remove_activelog.xslt $mytmp1 > $mytmp2

# Merging tracks and creating subsections for every 7 days
# Note that we use 'merge' instead of 'pack'
# gpsbabel -i gpx -f $mytmp1 -x track,merge,split=7d,title="LOG # %c" -o 'kml,trackdata=1,points=0,line_color=990000ff,labels=0,units=m' -F -
#gpsbabel -i gpx -f $mytmp1 -x track,merge -o 'kml,trackdata=1,points=0,line_color=990000ff,labels=0,units=m' -F -
#gpsbabel -i gpx -f $mytmp1 -o 'kml,trackdata=1,points=0,line_color=990000ff,labels=0,units=m' -F -

echo "Converting from gpx to kml"
gpsbabel -i gpx -f $mytmp2 -x 'position,distance=2000m' -o 'kml,trackdata=1,points=0,line_color=990000ff,labels=0,units=m' -F $1.kml

# Does not seem to work
# gpsbabel -i gpx -f $mytmp2 -x 'position,time=86400' -o 'kml,trackdata=1,points=0,line_color=990000ff,labels=0,units=m' -F $1.kml

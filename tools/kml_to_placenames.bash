
in="../kml/selected/four_continents.kml"

gpsbabel -i kml -f $in -x simplify,count=50 -o 'kml,trackdata=1,points=0,line_color=990000ff,labels=0,units=m' -F - | perl kml_to_placenames.perl | tee placenames.csv

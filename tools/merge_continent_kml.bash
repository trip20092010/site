
kml=../kml/
base=../kml/selected/

gpsbabel -i kml -f $kml/20090713.kml -f $base/africa.kml -f $kml/20091113.kml -f $kml/20091114.kml -f $base/south_america.kml -f $kml/20100407.kml -f $base/oceania.kml -f $kml/20100514.kml -f $base/asia.kml -f $kml/20100926.kml -x 'position,distance=3000m' -o "kml,trackdata=1,points=0,line_color=990000ff,line_width=3,labels=0,units=m" -F -

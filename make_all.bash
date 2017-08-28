echo "Backup tracks.html"
cp tracks.html /home/kaarel/Desktop/

echo "Making tracks.html"
cat tracks.raw | perl tools/make_tracks_page.perl > tracks.html

echo "Making storable/dates.storable"
cat tracks.raw | perl tools/make_date_country.perl > /dev/null

echo "Backup stat.html"
cp stat.html /home/kaarel/Desktop/

echo "Making stat.html"
cat stat.raw | perl tools/fill_template.perl > stat.html

echo "Backup index.html"
cp index.html /home/kaarel/Desktop/

echo "Making index.html"
cat index.raw | perl tools/fill_template.perl > index.html

echo "Diff tracks.html"
diff /home/kaarel/Desktop/tracks.html tracks.html

echo "Diff stat.html"
diff /home/kaarel/Desktop/stat.html stat.html

echo "Diff index.html"
diff /home/kaarel/Desktop/index.html index.html

echo "SKIPPING: Making modification_times.html"
#find . -name "*.html" | grep stories | xargs ls -g --time=ctime --time-style=long-iso | sed "s/  */ /g" | sed "s/ \.\// /" | cut -f5,6,7 -d' ' | sort -r | perl tools/2col_to_html.perl > modification_times.html

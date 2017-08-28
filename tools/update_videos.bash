cp ../data/videos.csv /tmp/videos.csv

python get_videos_as_tsv.py > ../data/videos.csv

wc -l /tmp/videos.csv ../data/videos.csv

diff /tmp/videos.csv ../data/videos.csv

cat ../data/videos.csv | python youtube_tsv_to_html.py > ../general/videos.html

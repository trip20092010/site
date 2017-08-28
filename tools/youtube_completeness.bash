onlaptop=/tmp/videos_on_laptop.txt
onyoutube=/tmp/videos_on_youtube.txt
echo "Videos on laptop"
find /media/ACER/Documents\ and\ Settings/Csilla/My\ Documents/My\ Pictures/ -name "*.MOV" | sed "s/.*\///" | sed "s/\..*//" > $onlaptop
wc -l $onlaptop


echo
echo "Videos on YouTube"
cat ../data/videos.csv | cut -f1 | sed "s/\..*//" > $onyoutube
wc -l $onyoutube

echo
echo "Not yet on YouTube:"
fgrep -vf $onyoutube $onlaptop | grep -v "^P103" | grep -v "^P104" | sort

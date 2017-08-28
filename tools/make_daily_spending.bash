
for doc in $(ls $1/*)
do
	date=`basename $doc | sed "s/\(.*\)\.csv/\1/"`
	echo "--------"
	echo $date
	echo "--------"
	cat $doc
done

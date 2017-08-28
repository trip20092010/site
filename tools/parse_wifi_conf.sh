cat $1 | egrep "Auto|\"id\"" | tr '\012' ' ' | sed 's/^.*mtime="\([^"]*\)".*>Auto \([^<]*\)<.*$/\1\t\2/'
echo

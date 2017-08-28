root=/home/kaarel/.gconf/system/networking/connections/

find $root -name "%gconf.xml" | xargs -n 1 bash parse_wifi_conf.sh | grep -v '^\s*$' | sort -nr

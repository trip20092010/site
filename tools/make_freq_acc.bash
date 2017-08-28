# Outputs the frequency distribution of accommodation types
cut -f2 | sed "s/,.*//" | sort | uniq -c | sort -nr

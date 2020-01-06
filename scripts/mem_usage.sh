free | grep Mem | awk '{ printf "%3.1f of %i GB", $3/1000000, $2/1000000 }'


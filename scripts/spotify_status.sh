status=`pidof spotify | wc -l`
if [ "$status" != 1 ]
then
	echo ""
else
	playback=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus' | grep -o Paused`

	if [ ! -z "$playback" ] && [ "$playback"="Paused" ]; then
		echo ""
	else
		icon="♫ "	
		META=`dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'`
		title=$(echo "$META" | grep -m 1 "xesam:title" -b1 | tail -n1)
    		title="${title%\"*}"
		title="${title#*\"}"

		artist=$(echo "$META" | grep -m 1 "xesam:artist" -b2 | tail -n1)
		artist="${artist%\"*}"
		artist="${artist#*\"}"

		echo "${icon} ${artist} - ${title}"
	fi
fi


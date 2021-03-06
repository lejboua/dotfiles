#!/bin/bash

i3status | while :
do
    read line

    dir=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
    spotify_status=$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus' | tail -n1 | cut -d'"' -f2 | sed -e 's/[\/&]/\\&/g')
    spotify_artist=$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | awk -f ${dir}/spotify_song.awk | head -n 1 | cut -d':' -f2 | sed -e 's/[\/&]/\\&/g')
    spotify_song=$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | awk -f ${dir}/spotify_song.awk | tail -n 1 | cut -d':' -f2 | sed -e 's/[\/&]/\\&/g')

    if [ "$spotify_status" = "Playing" ] ; then
	    echo $(echo "$line" | sed 's/{\"name/{\"name\":\"music\",\"full_text\":\" : '"$spotify_artist"' - '"$spotify_song"'\"},{\"name/') || exit 1
        continue
    fi
    echo -n $line || exit 1
done

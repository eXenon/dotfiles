#!/bin/sh

tasks=$(curl -s $(cat /home/cba/.productivity_api)/i3/status/todoist)

if [ -z "$tasks" ]; then
    echo "%{F#d60606} ?%{F-}"
    exit 0
fi

done=$(echo "$tasks" | cut -d"/" -f 1)
todo=$(echo "$tasks" | cut -d"/" -f 2 | tr -d " ")

if [ "$done" -ge "$todo" ]; then
    icon="%{F#3cb703}%{F-}"
else
    icon="%{F#f9dd04}%{F-}"
fi

echo "$icon $tasks"

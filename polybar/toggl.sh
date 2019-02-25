#!/bin/sh

toggl=$(curl -s $(cat /home/cba/.productivity_api)/i3/status/toggl)

if [ -z "$toggl" ]; then
    echo "%{F#d60606} ?%{F-}"
    exit 0
fi

icon="%{F#d3d7cf}%{F-}"

echo "$icon $toggl"

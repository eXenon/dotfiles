#!/bin/sh

HOST=1.1.1.1

rtt=$(ping $HOST -c 1 | sed -rn 's/.*time=([0-9]{1,})\.?[0-9]{0,} ms.*/\1/p')

if [ -z "$rtt" ]; then
    echo "%{F#d60606} ø%{F-}"
    exit 0
fi

if [ "$rtt" -lt 50 ]; then
    icon="%{F#3cb703}%{F-}"
elif [ "$rtt" -lt 150 ]; then
    icon="%{F#f9dd04}%{F-}"
else
    icon="%{F#d60606}%{F-}"
fi

echo "$icon $rtt ms"

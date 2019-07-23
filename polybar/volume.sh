#!/bin/sh

IS_MUTED=$(pamixer --get-mute)
if [ $IS_MUTED = "true" ]; then
    echo ﱝ
else
    echo " $(pamixer --get-volume)"
fi

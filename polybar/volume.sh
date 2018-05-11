#!/bin/sh

IS_MUTED=$(amixer -D pulse get Master | grep -o "\[on\]" | head -n1)
if [ -z $IS_MUTED ]; then
    echo ﱝ
else
    echo " $(amixer -D pulse get Master | grep -o "\[.*%\]" | grep -o "[0-9]*" | head -n1)"
fi

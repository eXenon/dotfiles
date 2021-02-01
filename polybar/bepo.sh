#!/bin/sh

if [ $# -eq 0 ]; then
    if [ -f "/tmp/bepo" ]; then
        echo "BÉ"
    else
        echo "FR"
    fi
else
    if [ $1 = "switch" ]; then
        if [ -f "/tmp/bepo" ]; then
            echo "Switching to azerty"
            setxkbmap fr
            rm -f "/tmp/bepo"
        else
            echo "Switching to bépo"
            setxkbmap fr bepo
            touch "/tmp/bepo"
        fi
    fi
fi

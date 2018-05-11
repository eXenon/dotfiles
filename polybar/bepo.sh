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
            touch "/tmp/azerty"
            rm -f "/tmp/bepo"
        else
            echo "Switching to bépo"
            setxkbmap fr bepo
            touch "/tmp/bepo"
            rm -f "/tmp/azerty"
        fi
    fi
fi

#!/bin/bash
 
# Dependencies:
# imagemagick
# i3lock-color-git
# scrot
 
IMAGE=/tmp/lock.screen.png
LOCK=/home/xnunn/.config/i3/lock.png
 
# All options are here: http://www.imagemagick.org/Usage/blur/#blur_args
BLURTYPE="0x5" # 7.52s
#BLURTYPE="0x2" # 4.39s
#BLURTYPE="5x3" # 3.80s
#BLURTYPE="2x8" # 2.90s
#BLURTYPE="2x3" # 2.92s

# This works for a monitor with 1920x1080 resolution
# It also works for my settings (two stacked 1920x1080 monitors)
# For other screen dispositions, adjuste the -geometry arguments
# For general purpose single monitor dispositions, use -gravity center instead

touch $IMAGE
scrot $IMAGE
convert $IMAGE -level 0%,100%,0.6 -blur $BLURTYPE -font Liberation-Sans -pointsize 26 -fill white -annotate +820+800 'Type password to unlock' - | composite -geometry +930+510 $LOCK - $IMAGE
i3lock --ringcolor=ffffff3e --linecolor=ffffff00 --keyhlcolor=ffffff80 --ringvercolor=2F3A61FF --insidevercolor=00000000 --ringwrongcolor=8F753BFF --insidewrongcolor=00000000  -i $IMAGE --singlescreen=0
rm $IMAGE

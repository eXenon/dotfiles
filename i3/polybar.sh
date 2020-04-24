#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload center &
        MONITOR=$m polybar --reload right &
        MONITOR=$m polybar --reload left &
    done;
else
    polybar --reload center &
    polybar --reload right &
    polybar --reload left &
fi

echo "Bars launched..."

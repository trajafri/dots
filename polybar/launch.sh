#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [ $m == 'eDP1' ]
    then
        polybar top &
        polybar bottom &
    fi
    if [ $m == 'HDMI1' ]
    then
        polybar top-HDMI &
        polybar bottom-HDMI &
    fi
done


#!/usr/bin/env bash

killall -q polybar

while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# launch bar
polybar --reload top -c ~/.config/polybar/config &

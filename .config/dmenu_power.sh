#!/usr/bin/env bash

set -e

options="


"

selected_options=$(echo "$options" | dmenu -fn 'JetBrainsMono Nerd Font-32' -y 500 -dim 0.4 -nb '#3C3836' -nf '#EBDBB2' -sb '#458588' -x 580 -w 619 -o 0.9)

if [ $selected_options == '' ]; then
  i3lock -i ~/Pictures/dim.png -B sigma -u
elif [ $selected_options == '' ]; then
  sudo systemctl suspend
elif [ $selected_options == '' ]; then
  sudo shutdown now
elif [ $selected_options == '' ]; then
  sudo reboot
fi


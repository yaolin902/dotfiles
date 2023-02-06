#!/bin/env bash

set -e

windows=$(i3-msg -t get_tree | jq '.. | objects |
    select(.window_type == "normal") |
    {name: (.window_properties.class + ": " + .name[0:15]), id: .id}')

selected_window=$(echo "$windows" | jq -r '.name' | dmenu -fn 'JetBrains Mono Regular Nerd Font Complete Mono-12' -y 500 -dim 0.4 -nb '#3C3836' -nf '#EBDBB2' -sb '#458588')
export selected_window

window_id=$(echo "$windows" | jq 'select(.name==env.selected_window) | .id') && i3-msg "[con_id=$window_id] focus"


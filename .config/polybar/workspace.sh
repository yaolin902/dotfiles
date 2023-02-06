#!/bin/bash

t=0
sleep_pid=0

toggle() {
  t=$(((t + 1) % 2))

  if [ "$sleep_pid" -ne 0 ]; then
    kill $sleep_pid >/dev/null 2>&1
  fi
}

trap "toggle" USR1

while true; do
  if [ $t -eq 0 ]; then
    echo " 缾 $(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2) "
  else
    cw=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2)
    #nt=$(i3-msg -t get_tree | jq '.. | objects' | grep tab)
    #if [ ! -z "$nt" ]; then
      echo " 缾$(i3-msg -t get_tree | jq '.. | objects | select(.type == "workspace") | select(.name != "__i3_scratch") | {name: (.name)|tonumber, nodes: [.nodes[] | .nodes[] | .window_properties | .class]} | .[]' | tr -d "\t\n\r \"" | sed -e 's/[0-9]/ & /g' -e 's/\,/ /g' -e 's/\[//g' -e 's/\]//g' | sed -e "s/$cw/[&]/g; s/kitty//g; s/firefox//g; s/burp-StartBurp/B/g; s/unityhub//g; s/discord/ﭮ/g; s/Spotify//g") "
    #else
      #echo " 缾$(i3-msg -t get_tree | jq '.. | objects | select(.type == "workspace") | select(.name != "__i3_scratch") | {name: (.name)|tonumber, nodes: [.nodes[] | .window_properties | .class]} | .[]' | tr -d "\t\n\r \"" | sed -e 's/[0-9]/ & /g' -e 's/\,/ /g' -e 's/\[//g' -e 's/\]//g' | sed -e "s/$cw/[&]/g; s/kitty//g; s/firefox//g; s/burp-StartBurp/B/g; s/unityhub//g") "
    #fi
  fi
  sleep 1 &
  sleep_pid=$!
  wait
done


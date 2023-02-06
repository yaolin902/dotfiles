#!/bin/bash

usb=$(lsblk -Jplno NAME,TYPE,RM,SIZE,MOUNTPOINT,VENDOR | jq -r '.blockdevices[] | select(.type == "disk") | select(.rm == true) | {vendor: .vendor, size: .size} | .[]' | sed -e '1 s/^\(.\{4\}\).*/\1/' | tr '\n' ' ') # | sed -e 's/[0-9]G/&/g')

if [ "$usb" = "" ]; then
  echo ""
else
  echo "  $usb"
fi


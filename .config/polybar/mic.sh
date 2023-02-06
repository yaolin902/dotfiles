#!/bin/sh

MIC_JACK="alsa_input.pci-0000_03_00.6.HiFi__hw_Generic_1__source"
USB_MIC="alsa_input.usb-0c76_USB_PnP_Audio_Device-00.mono-fallback"

if pacmd list-sources | grep -q $USB_MIC; then
  DEFAULT_SOURCE_INDEX="$USB_MIC"
else
  DEFAULT_SOURCE_INDEX="$MIC_JACK"
fi

#echo $DEFAULT_SOURCE_INDEX
display_volume() {
  if [ -z "$volume" ]; then
    echo "  "
  else
    volume="${volume//[[:blank:]]/}" 
    if [[ "$mute" == *"yes"* ]]; then
      echo "  "
    elif [[ "$mute" == *"no"* ]]; then
      echo "  $volume "
    else
      echo "  $volume "
    fi
  fi
}

case $1 in
  "show-vol")
      volume=$(pacmd list-sources | grep "$DEFAULT_SOURCE_INDEX" -A 6 | grep "volume" | awk -F/ '{print $2}')
      mute=$(pacmd list-sources | grep "$DEFAULT_SOURCE_INDEX" -A 11 | grep "muted" )
      display_volume
    ;;
  "inc-vol")
      pactl set-source-volume $DEFAULT_SOURCE_INDEX +5%
    ;;
  "dec-vol")
      pactl set-source-volume $DEFAULT_SOURCE_INDEX -5%
    ;;
  "mute-vol")
      pactl set-source-mute $DEFAULT_SOURCE_INDEX toggle
    ;;
  *)
    echo "Invalid script option"
    ;;
esac


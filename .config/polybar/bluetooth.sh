#!/bin/sh

bluetooth_print() {
  if [ "$(systemctl is-active "bluetooth.service")" = "inactive" ]; then
      echo " "
  fi
  if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
  then
      echo " "
  else
      if [ $(echo info | bluetoothctl | grep 'Device' | wc -c) -gt 0 ]
      then 
          devices_paired=$(bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2)
          for device in $devices_paired; do
              device_info=$(bluetoothctl info "$device")
                  if echo "$device_info" | grep -q "Connected: yes"; then
                      device_alias=$(echo "$device_info" | grep "Alias" | cut -d ' ' -f 2-)
                      echo " $device_alias"
                      break
                  fi
          done
      
    else
          echo " "
      fi
      fi
}

bluetooth_toggle() {
  if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
  then
      bluetoothctl power on
    else
        bluetoothctl power off
  fi
}

case "$1" in
    --toggle)
        bluetooth_toggle
        ;;
    *)
        bluetooth_print
        ;;
esac

#!/bin/bash

t=0
sleep_pid=0

print_bytes() {
    if [ "$1" -eq 0 ] || [ "$1" -lt 1000 ]; then
            bytes="0 KB/s"
              elif [ "$1" -lt 1000000 ]; then
                      bytes="$(echo "$1/1000" | bc -l | LANG=C xargs printf "%.f\n") KB/s"
                        else
                                bytes="$(echo "$1/1000000" | bc -l | LANG=C xargs printf "%.1f\n") MB/s"
                                  fi

                                    echo "$bytes"
                                  }


toggle() {
    t=$(((t + 1) % 2))

    if [ "$sleep_pid" -ne 0 ]; then
      kill $sleep_pid >/dev/null 2>&1
    fi
}

print_less() {
  if [ "$(systemctl is-active "iwd.service")" = "inactive" ]; then
    echo " 睊 "
    exit 0
  fi
  if [ "$(iwctl station wlan0 show | grep State | awk -F" " '{print $2}')" = "connected" ]; then
    if [ "$(iwgetid -r)" = "" ]; then
      echo " 睊 "
    else
      echo " 直 $(iwgetid -r | cut -c1-8 | sed 's/$/ /')"
    fi
  else
    echo " 睊 "
  fi
}

declare -A bytes
bytes[past_rx]="$(cat /sys/class/net/wlan0/statistics/rx_bytes)"
bytes[past_tx]="$(cat /sys/class/net/wlan0/statistics/tx_bytes)"

print_more() {
  if [ "$(systemctl is-active "iwd.service")" = "inactive" ]; then
    echo " 睊 "
    exit 0
  fi
  if [ "$(iwctl station wlan0 show | grep State | awk -F" " '{print $2}')" = "connected" ]; then
    if [ "$(iwgetid -r)" = "" ]; then
      echo " 睊 "
    else
      down=0
      up=0
      bytes[now_rx]="$(cat /sys/class/net/wlan0/statistics/rx_bytes)"
      bytes[now_tx]="$(cat /sys/class/net/wlan0/statistics/tx_bytes)"
      bytes_down=$((((${bytes[now_rx]} - ${bytes[past_rx]})) / 1))
      bytes_up=$((((${bytes[now_tx]} - ${bytes[past_tx]})) / 1))

      down=$(((( "$down" + "$bytes_down" ))))
      up=$(((( "$up" + "$bytes_up" ))))
      bytes[past_rx]=${bytes[now_rx]}
      bytes[past_tx]=${bytes[now_tx]}
      echo " 直 $(iwgetid -r) $(ip addr show wlan0 | grep "inet " | awk -F" " '{print $2}' | cut -d '/' -f 1)   $(print_bytes $down) 祝 $(print_bytes $up) "
    fi
  else
    echo " 睊 "
  fi
}

trap "toggle" USR1

while true; do
  if [ $t -eq 0 ]; then
    print_less
  else
    print_more
  fi
  sleep 1 &
  sleep_pid=$!
  wait
done

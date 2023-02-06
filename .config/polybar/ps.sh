#!/usr/bin/env bash

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
        echo ""
    else
      echo " $(ps h -eo ucmd,%cpu --sort=-%cpu | head -n3 | sed 's/ [0-9]/\n&/g' | sed 's/^[ ]*//g' | cut -c1-5 | sed 's/ //g' | tr '\n' ' ')"
    fi
    sleep 1 &
    sleep_pid=$!
    wait
done


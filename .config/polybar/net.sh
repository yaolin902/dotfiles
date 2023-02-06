#!/bin/bash

if cat /home/y41/.config/polybar/config | grep -q "wlan1 eth"; then
	sed -i 's/wlan1 eth/wlan eth/g' /home/y41/.config/polybar/config
else
	sed -i 's/wlan eth/wlan1 eth/g' /home/y41/.config/polybar/config
fi


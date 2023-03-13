#!/bin/bash

state() {
	local file="/tmp/screen_sh"

	if [ ! -f "$file" ]; then
		echo 0
		touch $file
		echo 1 >$file
	elif [ $(cat $file) -eq 1 ]; then
		echo 1
		echo 2 >$file
	else
		echo 2
		rm $file
	fi

}

mirror() {
	state="$(state)"

	if [ "xrandr | grep 'HDMI-1 disconnected' | wc -c " != "0" ]; then
		xrandr --output HDMI-1 --off --output eDP-1 --auto
	fi

	if [ "$state" -eq 0 ]; then
		if [ ! "xrandr | grep 'HDMI-1 connected' -A 1000 | grep '1920x1200' | wc -c " -eq 0 ]; then
			xrandr --output HDMI-1 --mode 1920x1200 --rate 60 --output eDP-1 --mode 1920x1200
		else
			resolution="$(xrandr | grep 'HDMI-1' -A 1 | sed -n '2p' | awk -F" " '{ print $1 }')"
			xrandr --output HDMI-1 --mode $resolution --rate 60 --scale-from 1920x1200 --output eDP-1 --mode 1920x1200
		fi
	elif [ "$state" -eq 1 ]; then
		if [ ! "xrandr | grep 'HDMI-1 connected' -A 1000 | grep '1920x1200' | wc -c " -eq 0 ]; then
			xrandr --output HDMI-1 --mode 1920x1200 --rate 60 --output eDP-1 --off
		else
			resolution="$(xrandr | grep 'HDMI-1' -A 1 | sed -n '2p' | awk -F" " '{ print $1 }')"
			xrandr --output HDMI-1 --mode $resolution --rate 60 --scale-from 1920x1200 --output eDP-1 --off
		fi
	else
		xrandr --output HDMI-1 --off --output eDP-1 --auto
	fi

	echo "mirror"
}
extend() {
	state="$(state)"
	echo "extend"
}

for i in "$@"; do
	case $i in
	mirror)
		mirror
		;;
	extend)
		extend
		;;
	esac
done

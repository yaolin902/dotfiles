#!/bin/bash

port="$2"
orig_port="$(xrandr | sed -n "2p" | awk -F" " '{ print $1 }')"
orig_resolution="$(xrandr | sed -n "3p" | awk -F" " '{ print $1 }')"

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

	if [ ! "xrandr | grep '$port disconnected' | wc -c " -eq 0 ]; then
		xrandr --output $port --off --output $orig_port --auto
	else
		if [ "$state" -eq 0 ]; then
			if [ ! "xrandr | grep '$port connected' -A 1000 | grep '$orig_resolution' | wc -c " -eq 0 ]; then
				xrandr --output $port --mode $orig_resolution --rate 60 --output $orig_port --mode $orig_resolution
			else
				resolution="$(xrandr | grep $port -A 1 | sed -n '2p' | awk -F" " '{ print $1 }')"
				xrandr --output $port --mode $resolution --rate 60 --scale-from $orig_resolution --output $orig_port --mode $orig_resolution
			fi
		elif [ "$state" -eq 1 ]; then
			if [ ! "xrandr | grep '$port connected' -A 1000 | grep '$orig_resolution' | wc -c " -eq 0 ]; then
				xrandr --output $port --mode $orig_resolution --rate 60 --output $orig_port --off
			else
				resolution="$(xrandr | grep $port -A 1 | sed -n '2p' | awk -F" " '{ print $1 }')"
				xrandr --output $port --mode $resolution --rate 60 --scale-from $orig_resolution --output $orig_port --off
			fi
		else
			xrandr --output $port --off --output $orig_port --auto
		fi
	fi
}
extend() {
	state="$(state)"

	if [ ! "xrandr | grep '$port disconnected' | wc -c " -eq 0 ]; then
		xrandr --output $port --off --output $orig_port --auto
	else
		if [ "$state" -eq 0 ]; then
			if [ ! "xrandr | grep '$port connected' -A 1000 | grep '$orig_resolution' | wc -c " -eq 0 ]; then
				xrandr --output $port --mode $orig_resolution --rate 60 --right-of $orig_port --output $orig_port --mode $orig_resolution
			else
				resolution="$(xrandr | grep $port -A 1 | sed -n '2p' | awk -F" " '{ print $1 }')"
				xrandr --output $port --mode $resolution --rate 60 --scale-from $orig_resolution --right-of $orig_port --output $orig_port --mode $orig_resolution
			fi
		elif [ "$state" -eq 1 ]; then
			xrandr --output $port --off --output $orig_port --auto
			if [ ! "xrandr | grep '$port connected' -A 1000 | grep '$orig_resolution' | wc -c " -eq 0 ]; then
				xrandr --output $port --mode $orig_resolution --rate 60 --left-of $orig_port --output $orig_port --mode $orig_resolution
			else
				resolution="$(xrandr | grep $port -A 1 | sed -n '2p' | awk -F" " '{ print $1 }')"
				xrandr --output $port --mode $resolution --rate 60 --left-of $orig_port --output $orig_port --mode $orig_resolution
			fi
		else
			xrandr --output $port --off --output $orig_port --auto
		fi
	fi
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

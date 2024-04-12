#!/bin/bash

help_function() {
	echo "Usage: $0 [-h] [on|off|toggle]"
	echo "Control the fan speed of your computer."
	echo "Options:"
	echo "  -h, --help      Display this help message"
	echo "Commands:"
	echo "  on              Turn the fan on (high speed)"
	echo "  off             Turn the fan off"
	echo "  toggle          Toggle the fan speed between on and off"
}

set_fan_speed() {
	local new_value
	case "$1" in
	on) new_value=0 ;;
	off) new_value=2 ;;
	toggle)
		current_value=$(<"$FILE")
		if [ "$current_value" -eq 0 ]; then
			new_value=2
		else
			new_value=0
		fi
		;;
	*)
		echo "Invalid command: $1"
		help_function
		exit 1
		;;
	esac
	echo "$new_value" | sudo tee "$FILE" >/dev/null
	if [ "$new_value" -eq 0 ]; then
		echo "Fan speed set to: High"
	else
		echo "Fan speed set to: Low"
	fi
}

case "$1" in
-h | --help)
	help_function
	exit 0
	;;
on | off | toggle)
	FILE="/sys/devices/platform/asus-nb-wmi/hwmon/hwmon5/pwm1_enable"
	set_fan_speed "$1"
	;;
*)
	echo "Invalid command: $1"
	help_function
	exit 1
	;;
esac

#!/bin/sh

# Automatically rotate the screen when the device's orientation changes.
# and 'xinput' to get the correct input element for your touch screen, if applicable
# (for example,  "Wacom HID 486A Finger").
#
# The script depends on the monitor-sensor program from the iio-sensor-proxy package.

# You can your monitor from xrandr
monitor="eDP1"

# You can get your touch inputs from xinput
finger="Wacom HID 5196 Finger" 
pen="Wacom HID 5196 Pen Pen (0xad4c1350)"
eraser="Wacom HID 5196 Pen Eraser (0xad4c1350)"

monitor-sensor \
	| grep --line-buffered "Accelerometer orientation changed" \
	| grep --line-buffered -o ": .*" \
	| while read -r line; do
		line="${line#??}"
		if [ "$line" = "normal" ]; then
			rotate=normal
			matrix="0 0 0 0 0 0 0 0 0"
		elif [ "$line" = "left-up" ]; then
			rotate=left
			matrix="0 -1 1 1 0 0 0 0 1"
		elif [ "$line" = "right-up" ]; then
			rotate=right
			matrix="0 1 0 -1 0 1 0 0 1"
		elif [ "$line" = "bottom-up" ]; then
			rotate=inverted
			matrix="-1 0 1 0 -1 1 0 0 1"
		else
			echo "Unknown rotation: $line"
			continue
		fi

		# Set monitor orientation
		xrandr --output "$monitor" --rotate "$rotate"
		# Set touch input orientation
		xinput set-prop "$finger" --type=float "Coordinate Transformation Matrix" $matrix
		xinput set-prop "$pen"    --type=float "Coordinate Transformation Matrix" $matrix
		xinput set-prop "$eraser" --type=float "Coordinate Transformation Matrix" $matrix
	done
	

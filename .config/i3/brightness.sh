#!/bin/bash

############################################################################# 
# This script "resolves" a bug with polybar's backlight module not updating #
# when the brightness changes.                                              #
#                                                                           #
# See https://github.com/jaagr/polybar/issues/1180                          #
#############################################################################

sleep 1;
cat /sys/class/backlight/intel_backlight/brightness /sys/class/backlight/intel_backlight/actual_brightness



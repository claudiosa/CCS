#!/bin/bash
xrandr --output LVDS-1 --mode 1366x768 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output VGA-1 --mode 1366x768 --pos 1366x0 --rotate normal
echo "OK via arandr"

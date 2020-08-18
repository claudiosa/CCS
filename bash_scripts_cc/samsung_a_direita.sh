#!/bin/bash
### xrandr -q  %%% ver os nomes dos monitores reconhecidos  --left-of LVDS-0
  xrandr --output eDP1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output DP1 --mode 1366x768 --pos 1366x0 --rotate normal --output HDMI1 --off --output VIRTUAL1 --off
echo "monitores OK ...."

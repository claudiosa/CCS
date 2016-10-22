#!/bin/bash
### xrandr -q  %%% ver os nomes dos monitores reconhecidos
 xrandr --output LVDS-0 --mode 1366x768 --rate 60
 xrandr --output VGA-0  --mode 1600x900 --rate 60
 xrandr --output VGA-0  --right-of LVDS-0
echo "monitores OK ...."

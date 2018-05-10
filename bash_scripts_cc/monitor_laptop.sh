#!/bin/bash
xrandr --newmode  "1600x900_60.00" 118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync 
xrandr --addmode LVDS1 1600x900_60.00
xrandr --output LVDS1 --mode 1600x900_60.00
echo "monitor do LAPTOP OK"
#$ cvt 1600 900 60  -- OK
# 1600x900 59.95 Hz (CVT 1.44M9) hsync: 55.99 kHz; pclk: 118.25 MHz
#Modeline "1600x900_60.00"  118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync


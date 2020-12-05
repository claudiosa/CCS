#!/bin/bash/
#lxterminal -e ./logout.sh  suspend
dbus-send --print-reply --system --dest=org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.Suspend

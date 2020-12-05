#!/bin/sh
# Released under the WTFPL by Loubrix, without any warranty.
# You can name your script "exitdesk.sh", and put it in a ~/.script directory.
# Don't forget to 'chmod +x exitdesk.sh'.
# You have to call this script with an argument, like this:
# ~/.script/exitdesk.sh halt
# Supported arguments are "halt", "reboot", "suspend", or "hibernate".
# You can call this script with a menu entry.
# Only use as non-privilege user, not root !
# Enjoy

case "$1" in
        halt)
                dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop
        ;;
        reboot)
                dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart
        ;;
        suspend)
                dbus-send --print-reply --system --dest=org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.Suspend
        ;;
        hibernate)
                dbus-send --print-reply --system --dest=org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.Hibernate
        ;;
        *)
                echo 'This script accepts the following arguments: halt, reboot, suspend, hibernate'
    ;;
esac

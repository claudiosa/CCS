#!/bin/bash
#setxkbmap fr
#mkfs.vfat /dev/sdb
###dd if=maratona-linux-20180904-usb_3.5GB.img of=/dev/sdb bs=4096  status=progress && sync
dd if=maratona-linux-20180904-usb_3.5GB.img of=/dev/sdb bs=4096  status=progress  conv=fdatasync
echo "Tudo sincronizado !!!"

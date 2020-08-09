#!/bin/sh
lsblk
## or dmesg
fdisk  /dev/sdb   ## the media can be mounted
mkfs.vfat /dev/sdb
sudo dd if=Zorin-OS-15.2-Lite-64-bit.iso of=/dev/sdb  bs=4096 status=progress
bs=4096  status=progress && sync

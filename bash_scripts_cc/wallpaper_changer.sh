#!/bin/bash# Script to randomly set Background from files in a directory
while true;do
# specify how long to wait in seconds between changes
sleep 1
# Directory Containing Pictures
DIR="/home/ccs/principal/diversos_do_sistema/papeis_de_parede"

# Command to Select a random jpg file from directory
# Delete the *.jpg to select any file but it may return a folder
PIC=$(ls $DIR/*.jpg | shuf -n1)
echo $PIC
# Command to set Background Image
mateconftool-2 -t string -s /home/ccs/Dropbox/sistema_conf/papeis_parede/picture_filename $PIC
#mateconftool-2 -t string -s /home/ccs/Dropbox/sistema_conf/papeis_parede/picture_filename $PIC
done

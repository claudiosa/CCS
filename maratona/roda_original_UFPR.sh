#!/bin/bash

if (( $# != 1 )); then
    echo "$0 <url_do_webcast>"
    exit
fi

### /var/www/boca/src/private/webcast
### /var/www/boca/src/webcast
### 200.19.107.67

URL=$1
mkdir -p TEMP_LOCAL
./main.py TEMP_LOCAL &

while ((1)); do
    cd TEMP_LOCAL
    rm -f *
    wget "${URL}/contest"
    wget "${URL}/runs"
    wget "${URL}/time"
    NUMPROBS=$(head -n 3 contest | tail -n 1 | awk -F'\x1c' '{print $2}')
    echo -ne "1 1\n" >> contest
    echo -ne "${NUMPROBS} Y\n" >> contest
    cd ..
    sleep 10
done

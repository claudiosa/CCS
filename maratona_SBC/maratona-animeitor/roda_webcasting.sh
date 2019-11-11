#!/bin/bash

if (( $# != 1 )); then
    echo "$0 <url_do_webcast>"
    exit
fi

URL=$1
mkdir -p temp_DIR

./main.py temp_DIR ${2} ${3} &

while (  true  ) ; 
   do
    cd temp_DIR
    rm -f *
    wget "${URL}/boca/webcast1984/contest"
    wget "${URL}/boca/webcast1984/runs"
    wget "${URL}/boca/webcast1984/time"
    cd ..
    sleep 10
done

## ./roda_webcasting.sh IPBOCA -s prefix

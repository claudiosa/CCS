#!/bin/bash

for f in *_HDR_PORTRAIT.jpg; do
    [ -e "$f" ] || continue
    novo="${f%_HDR_PORTRAIT.jpg}.jpg"
    mv -n -- "$f" "$novo"
done

for f in *_HDR.jpg; do
    [ -e "$f" ] || continue
    novo="${f%_HDR.jpg}.jpg"
    mv -n -- "$f" "$novo"
done

echo "DONE it"

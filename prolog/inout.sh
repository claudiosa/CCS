#!/bin/bash

cat $1 $2 > tmpfile
pl --goal=main -o "$prefix" -c tmpfile
./tmpfile > $1.saida

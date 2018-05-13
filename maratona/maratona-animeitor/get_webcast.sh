#!/bin/bash

mkdir $1
wget ${2}version/ -O $1/version
wget ${2}runs/ -O $1/runs
wget ${2}contest/ -O $1/contest
wget ${2}time/ -O $1/time

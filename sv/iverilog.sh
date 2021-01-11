#!/bin/sh

PROJ=
SV=

. ./proj.cfg

exe=$(echo $TB | cut -f 1 -d '.')
iverilog -g2012 -o $PROJ *.tb $SV && ./$exe
#!/bin/sh

set -e

PROJ=
TOP=
SV=

. ./proj.cfg

if [ -z "$TOP" ]; then
	TOP=$PROJ
fi

rm -rf obj_dir

verilator +systemverilogext+sv -Wall --trace -cc $TOP
make -C obj_dir -f V$TOP.mk
g++ -I /usr/share/verilator/include /usr/share/verilator/include/verilated.cpp /usr/share/verilator/include/verilated_vcd_c.cpp sim.cpp obj_dir/V${TOP}__ALL.a -o sim
./sim
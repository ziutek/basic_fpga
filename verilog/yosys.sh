#!/bin/sh

set -e

name=$(basename $(pwd))
build=yosys


mkdir -p $build
rm -rf $build/*

yosys <<EOF
read_verilog *.v
synth_xilinx -family xc6s -ise -top top
write_edif $build/$name.edif
EOF

PART=xc6slx16-ftg256-2

cd $build

ngdbuild -p xc6slx16-ftg256-2 -uc ../project.ucf $name
map -p xc6slx16-ftg256-2 -mt 2 -w $name
par -mt 4 -w blinky blinky
bitgen -w blinky
xc3sprog -c bbv2_2 blinky.bit
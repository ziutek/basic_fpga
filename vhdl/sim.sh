#!/bin/sh

name=$(basename $(pwd))

mkdir -p ghdl
ghdl -i --workdir=ghdl *.vhdl
ghdl -m --workdir=ghdl ${name}Sim
ghdl -r --workdir=ghdl ${name}Sim --vcd=sim.vcd $@
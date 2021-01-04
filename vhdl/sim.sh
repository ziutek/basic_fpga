#!/bin/sh

name=$(basename $(pwd))

mkdir -p ghdl
ghdl -a --workdir=ghdl *.vhdl
ghdl -r --workdir=ghdl ${name}Sim --vcd=sim.vcd $@
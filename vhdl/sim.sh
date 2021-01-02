#!/bin/sh

name=$(basename $(pwd))

mkdir -p sim
ghdl -a --workdir=sim *.vhdl
ghdl -r --workdir=sim ${name}Sim --vcd=sim.vcd $@
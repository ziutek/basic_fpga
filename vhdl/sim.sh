#!/bin/sh

name=$(basename $(pwd))

mkdir -p sim
ghdl -a --workdir=sim --std=08 *.vhdl
ghdl -r --workdir=sim --std=08 ${name}Sim --vcd=sim.vcd $@
#include <stdio.h>
#include <stdlib.h>
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "obj_dir/Vcounter.h"

VerilatedVcdC *v;
int timeStamp;

void tick(Vcounter *tb) {
	tb->clk = 0;
	tb->eval();
	v->dump(timeStamp);
	timeStamp++;
	tb->clk = 1;
	tb->eval();
	v->dump(timeStamp);
	timeStamp++;
}


int main(int argc, char **argv) {
	Verilated::commandArgs(argc, argv);
	Verilated::traceEverOn(true);

	v = new VerilatedVcdC;
	v->open("coutner.vcd");

	Vcounter *tb = new Vcounter;
	tb->trace(v, 99);
	tb->reset = 1;
	for (int i = 0; i < 5; i++) {
		tick(tb);
	}
	tb->reset = 0;
	for (int i = 0; i < 20; i++) {
		tick(tb);
	}

	v->close();
}
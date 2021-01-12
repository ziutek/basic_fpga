#include <stdio.h>
#include <stdlib.h>
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "obj_dir/VPWMLED.h"

VerilatedVcdC *v;
int timeStamp;

void tick(VPWMLED *tb) {
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

	VPWMLED *tb = new VPWMLED;

	v = new VerilatedVcdC;
	tb->trace(v, 99);
	v->open("sim.vcd");

	for (int i = 0; i < 100; i++) {
		tick(tb);
	}

	v->close();
}
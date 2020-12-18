#include <stdio.h>
#include <stdlib.h>
#include "verilated.h"
#include "obj_dir/Vtop.h"

void ticks(Vtop *tb, int n) {
	n *= 2;
	for (int i = 0; i < n; i++) {
		tb->clk = i & 1;
		tb->eval();
		printf("%d  %d\n", tb->clk, tb->count);
	}
}


int main(int argc, char **argv) {
	Verilated::commandArgs(argc, argv);
	Vtop *tb = new Vtop;

	ticks(tb, 20);
}
#include <stdio.h>
#include <stdlib.h>
#include "verilated.h"
#include "obj_dir/Vtop.h"

int main(int argc, char **argv) {
	Verilated::commandArgs(argc, argv);
	Vtop *tb = new Vtop;

	for (int k = 0; k < 20; k++) {
		tb->clk50 = k & 1;
		tb->uartRx = (k > 10);
		tb->eval();
		printf("k=%2d, clk50=%d, uartTx=%d\n", k, tb->clk50, tb->uartTx);
	}
}
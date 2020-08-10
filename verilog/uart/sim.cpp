#include <stdio.h>
#include <stdlib.h>
#include "verilated.h"
#include "obj_dir/Vtop.h"

void ticks(Vtop *tb, int n) {
	for (int i = 0; i < n; i++) {
		tb->clk = i & 1;
		tb->eval();
		printf("%d  %d %d\n", tb->clk, tb->rx, tb->state);
	}
	printf("--\n");
}

void uart(Vtop *tb, char *tx) {
	for (int n = 0; tx[n] != '\0'; n++) {
		// start bit
		tb->rx = 0;
		ticks(tb, 16);

		// data bits
		for (int i = 0; i < 8; i++) {
			tb->rx = (tx[n]>>i) & 1;
			ticks(tb, 16);
		}

		// stop bit
		tb->rx = 1;
		ticks(tb, 16);

		printf("char: %c\n", tb->out);
	}
}

int main(int argc, char **argv) {
	Verilated::commandArgs(argc, argv);
	Vtop *tb = new Vtop;

	tb->rx = 1;
	ticks(tb, 10);

	char tx[] = "$1";

	uart(tb, tx);
}
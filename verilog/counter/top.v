`default_nettype none

//verilator lint_off MULTIDRIVEN
//verilator lint_off UNOPT

module top(
	input wire clk,
	output reg[3:0] count
);

initial count = 4'b0;

always @( negedge clk ) count[0] <= ~count[0];

always @( negedge count[0] ) count[1] <= ~count[1];

always @( negedge count[1] ) count[2] <= ~count[2];

always @( negedge count[2] ) count[3] <= ~count[3];

endmodule

//verilator lint_on UNOPT
//verilator lint_on MULTIDRIVEN


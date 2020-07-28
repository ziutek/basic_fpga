`default_nettype none

module top(
	input  wire clk50,

	input  wire uartRx,
	output reg  uartTx,

	input  wire btn0,

	output wire led0,
	output wire led1
);

	assign led0 = btn0 ? uartTx : 1;
	assign led1 = btn0 ? 1 : uartTx;

	always @(posedge clk50) uartTx <= uartRx;

endmodule

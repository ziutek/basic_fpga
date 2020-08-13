`default_nettype none

module top(
	input wire clk50,
	input wire uartRx,
	output reg led0,
	output reg led1
);

reg [8:0] uartCnt;

localparam uartDiv = 50_000_000 * 16 / 115_200;

always @(posedge clk50) begin
	uartCnt <= (uartCnt < uartDiv) ? uartCnt + 1'b1 : 9'b0;
end

wire [7:0] uartOut;
wire uartValid;

uart u (
	.clk(uartCnt[8]),
	.rx(uartRx),
	.out(uartOut),
	.valid(uartValid)
);

initial led0 = 1;
initial led1 = 1;

always @(posedge uartValid) case (uartOut)
8'h30: begin
		led0 <= 0;
		led1 <= 1;
	end
8'h31: begin
		led1 <= 0;
		led0 <= 1;
	end
default: begin
		led0 <= 1;
		led1 <= 1;
	end
endcase


endmodule

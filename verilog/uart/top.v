`default_nettype none

module top(
	input wire clk,
	input wire rx,
	output reg [7:0] out,
	output reg [1:0] state
);

initial state = idle;

localparam idle = 0;
localparam start = 1;
localparam data = 2;
localparam stop = 3;

//reg [1:0] state = idle;
reg [3:0] subCnt;
reg [3:0] bitCnt;
reg       carry;

always @(posedge clk) begin
	{carry, subCnt} <= subCnt + 1'b1;
	case (state)
	idle:
		if (rx == 0) begin
			subCnt <= 8;
			state <= start;
		end
	start:
		if (carry) begin
			bitCnt <= 0;
			out <= 0;
			state <= data;
		end
	data:
		if (carry) begin
			out <= {out[6:0], rx};
			bitCnt <= bitCnt + 1'b1;
			state <= stop;
		end
	default: // stop
		if (subCnt[3]) state <= idle;
	endcase
end

endmodule

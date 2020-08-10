`default_nettype none

module top(
	input wire clk,
	input wire rx,
	output reg [7:0] out,
	output reg valid
);

localparam IDLE  = 0;
localparam START = 1;
localparam DATA  = 2;
localparam STOP  = 3;

reg [1:0] state = IDLE;
reg [3:0] subCnt;
reg [3:0] bitCnt;
reg       carry;

always @(posedge clk) begin
	if (state == IDLE) begin
		if (rx == 0) begin
			subCnt <= 9;
			state <= START;
		end
	end else begin
		case (state)
		START:
			if (carry) begin
				bitCnt <= 1;
				state <= DATA;
			end
		DATA:
			if (carry) begin
				out <= {rx, out[7:1]};
				if (bitCnt[3]) begin
					valid <= 1;
					state <= STOP;
				end
				bitCnt <= bitCnt + 1'b1;
			end
		default: // STOP
			begin
				valid <= 0;
				if (carry) state <= IDLE;
			end
		endcase
		{carry, subCnt} <= subCnt + 1'b1;
	end
end

endmodule

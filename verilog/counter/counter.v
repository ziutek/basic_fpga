`default_nettype none

module counter(
	input wire clk,
	input wire reset,
	output reg[4:0] count = 0
);

always @(negedge clk) begin
	if (reset) begin
		count <= 0;
	end else begin
		count <= count + 1;
	end
end

endmodule

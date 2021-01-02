`default_nettype none

module pwm #(
	pwmBits = 1
)(
	input  wire               clk,
	input  wire [pwmBits-1:0] duty,
	output reg                pwmOut
);

reg [pwmBits-1:0] cnt;

always @(posedge clk) begin
	cnt <= cnt + 16'b1;
	if (cnt < duty) begin
		pwmOut <= 1;
	end else begin
		pwmOut <= 0;
	end
end

endmodule
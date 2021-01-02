`default_nettype none

module pwmled #(
	pwmBits = 16,
	cntBits = 12
)(
	input  wire clk50,
	output wire led0,
	output reg  led1
);

reg [cntBits+pwmBits-1:0] cnt;

always @(posedge clk50) begin
	cnt <= cnt + 28'b1;
	led1 <= cnt[26];
end

pwm #(
	.pwmBits(pwmBits)
) pwm1 (
	.clk(clk50),
	.duty(cnt[cntBits+pwmBits-1:cntBits]),
	.pwmOut(led0)
);

endmodule
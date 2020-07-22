module pwm(output led0, input clk50);

	reg [24:0] cnt = 25'd0;
	always @(posedge clk50) cnt <= cnt + 1;

	wire [3:0] PWM_input = cnt[24] ? cnt[23:20] : ~cnt[23:20];
	reg [4:0] PWM;
	always @(posedge clk50) PWM <= PWM[3:0] + PWM_input;

	assign led0 = PWM[4];
endmodule

module pwmled #(
	dutyBits = 12,
	cntBits  = 26
) (
	input  logic clk50,
	output logic led0,
	output logic led1
);
	localparam dutyMax = {dutyBits {1'sb1}};

	logic [cntBits-1:0]  cnt;
	logic [dutyBits-1:0] duty;

	PWM #(dutyBits) pwm (clk50, duty, led0);

	always_ff @(posedge clk50) begin
		cnt <= cnt + 1'b1;
		if (cnt == 0) begin
			if (duty == 0) begin
				duty <= dutyMax;
			end else begin
				duty <= duty>>1;
			end
		end
	end
	assign led1 = (cnt < 26'b10000000000000000000000000);
endmodule

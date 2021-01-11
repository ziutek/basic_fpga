module PWMLED #(
	dutyBits = 19,
	cntBits  = 23
) (
	input  logic clk50,
	output logic led0,
	output logic led1
);
	localparam dutyMax = {dutyBits {1'sb1}};

	logic [cntBits-1:0]  cnt;
	logic [dutyBits-1:0] duty;
	logic                pwm;

	PWM #(dutyBits) pwm0 (clk50, duty, pwm);

	wire isZero = duty[0] == 0;
	wire isMax  = duty[$high(duty)] == 1;
	logic dir;

	always_ff @(posedge clk50) begin
		cnt <= cnt + 1'b1;
		if (cnt == '1) begin
			if (isZero) begin
				duty[0] <= 1;
				dir <= 1;
			end
			if (isMax) begin
				duty[$high(duty)] <= 0;
				dir <= 0;
			end
			if (!isZero && !isMax) begin
				duty <= dir ? (duty<<1)|$size(duty)'(1) : duty>>1;
			end;
		end
	end

	always_comb begin
		led0 = ~pwm;
		led1 = 1;
	end
endmodule

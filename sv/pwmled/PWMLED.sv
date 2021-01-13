`default_nettype none

module PWMLED #(
	dutyBits = 19,
	cntBits  = 23
) (
	input  wire clk,
	output wire led0, led1
);
	reg  [dutyBits-1:0] duty;
	wire                pwm;

	PWM #(dutyBits) pwm0 (.clk, .duty, .out(pwm));

	wire isZero = duty[0] == 0;
	wire isMax  = duty[$high(duty)] == 1;

	reg [cntBits-1:0] cnt;
	reg               dir;

	always_ff @(posedge clk) begin
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
				duty <= dir ? (duty << 1) | dutyBits'(1) : duty >> 1;
			end;
		end
	end

	assign
		led0 = ~pwm,
		led1 = 1;
endmodule

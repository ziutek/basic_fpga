`default_nettype none

module PWMLED #(
	dutyBits = 19,
	cntBits  = 23
) (
	input  wire  clk,
	output logic led0,
	output wire  led1
);
	logic [dutyBits-1:0] duty;
	wire                 out;

	PWM #(dutyBits) pwm0 (.clk, .duty, .out);

	wire isZero = duty[0] == 0;
	wire isMax  = duty[$high(duty)] == 1;

	logic [cntBits-1:0] cnt;
	logic               dir;

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
		led0 = ~out,
		led1 = 1;
endmodule

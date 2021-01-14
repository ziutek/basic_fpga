//verilator --lint-only --Wall

`default_nettype none

module pwm #(
	dutyBits = 2
) (
	input
		wire                 clk,
		wire  [dutyBits-1:0] duty,
	output
		logic                out
);
	logic [dutyBits-1:0] cnt;

	always_ff @(posedge clk) begin
		cnt <= cnt + 1'b1;
	end

	assign out = (cnt < duty);
endmodule

module ledpwm (input wire clk, output wire led);
	localparam dutyBits = 8;

	wire [dutyBits-1:0] duty = 123;

	pwm #(dutyBits) pwm1 (.clk, .duty, .out(led));
endmodule
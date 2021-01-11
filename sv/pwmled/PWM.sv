module PWM #(
	dutyBits = 2
) (
	input  logic                clk,
	input  logic [dutyBits-1:0] duty,
	output logic                out
);
	logic [dutyBits-1:0] cnt;

	always_ff @(posedge clk) begin
		cnt <= cnt + 1'b1;
	end

	assign out = (cnt < duty);
endmodule

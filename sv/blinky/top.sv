`default_nettype none

module blinky (
	input  wire clk50,
	output reg  led0,
	output wire led1
);
	wire loop, sysClk, clk100;

	PLL_BASE #(
		.CLKIN_PERIOD(20.000), // 50 MHz.
		.CLKFBOUT_MULT(8),    // 400 MHz
		.CLKOUT0_DIVIDE(4)    // 100 MHz
	) sysPLL (
		.CLKFBIN(loop),
		.CLKFBOUT(loop),
		.CLKIN(clk50),
		.CLKOUT0(clk100),
		.CLKOUT1(),
		.CLKOUT2(),
		.CLKOUT3(),
		.CLKOUT4(),
		.CLKOUT5(),
		.LOCKED(),
		.RST(1'b0)
	);

	BUFG bufg(.O(sysClk), .I(clk100));

	reg [26:0] counter;

	always_ff @(posedge sysClk) begin
		if (counter == 'd99_999_999) begin
			counter <= 0;
			led0 <= ~led0;
		end else begin
			counter <= counter + 1'b1;
		end
	end

	assign led1 = !led0;
endmodule

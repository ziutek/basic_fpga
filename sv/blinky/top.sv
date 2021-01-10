module blinky #(
	N = 27
) (
	input  logic clk50,
	output logic led0,
	output logic led1
);
	logic loop;
	logic sysClk;
	logic clk100;

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

	logic [N-1:0] counter;

	always_ff @(posedge sysClk) begin
		if (counter == 27'd99_999_999) begin
			counter <= 0;
		end else begin
			counter <= counter + 1'b1;
		end
		led0 <= led0 ^ (counter == 0);
	end

	assign	led1 = !led0;
endmodule

`default_nettype none

module top(
	input  wire extClk50,
	output reg  led0,
	output wire led1
);

wire loop;
wire sysClk;
wire clk100;

PLL_BASE #(
	.CLKIN_PERIOD(20.000), // 50 MHz.
	.CLKFBOUT_MULT(8),    // 400 MHz
	.CLKOUT0_DIVIDE(4)    // 100 MHz
) sysPLL (
	.CLKFBIN(loop),
	.CLKFBOUT(loop),
	.CLKIN(extClk50),
	.CLKOUT0(clk100),
	.CLKOUT1(),
	.CLKOUT2(),
	.CLKOUT3(),
	.CLKOUT4(),
	.CLKOUT5(),
	.LOCKED(),
	.RST(1'b0)
);

BUFG bufg(.O (sysClk), .I (clk100));

reg [26:0] counter = 0;

always @(posedge sysClk) begin
	counter <= (counter == 27'd99_999_999) ? 27'd0 : counter + 27'd1;
	led0 <= led0 ^ (counter == 27'd0);
end

assign led1 = !led0;

endmodule

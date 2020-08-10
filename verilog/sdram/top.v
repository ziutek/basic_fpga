`default_nettype none

module top(
	input  wire extClk50,
	output reg  led0,
	output wire led1
);

wire loop;
wire clk100;

PLL_BASE #(
	.BANDWIDTH("OPTIMIZED"),
	.CLKIN_PERIOD(20.000), // 50 MHz.
	.CLKFBOUT_MULT(8),    // 400 MHz
	.CLKFBOUT_PHASE(0.0),
	.CLKOUT0_DIVIDE(4),   // 100 MHz
	.CLKOUT1_DIVIDE(1),
	.CLKOUT2_DIVIDE(1),
	.CLKOUT3_DIVIDE(1),
	.CLKOUT4_DIVIDE(1),
	.CLKOUT5_DIVIDE(1),
	.CLKOUT0_DUTY_CYCLE(0.5),
	.CLKOUT1_DUTY_CYCLE(0.5),
	.CLKOUT2_DUTY_CYCLE(0.5),
	.CLKOUT3_DUTY_CYCLE(0.5),
	.CLKOUT4_DUTY_CYCLE(0.5),
	.CLKOUT5_DUTY_CYCLE(0.5),
	.CLKOUT0_PHASE(0.0),
	.CLKOUT1_PHASE(0.0),
	.CLKOUT2_PHASE(0.0),
	.CLKOUT3_PHASE(0.0),
	.CLKOUT4_PHASE(0.0),
	.CLKOUT5_PHASE(0.0),
	.CLK_FEEDBACK("CLKFBOUT"),
	.COMPENSATION("SYSTEM_SYNCHRONOUS"),
	.DIVCLK_DIVIDE(1),
	.REF_JITTER(0.1),
	.RESET_ON_LOSS_OF_LOCK("FALSE")
) sysPLL (
	.CLKFBOUT(loop),
	.CLKOUT0(clk100),
	//.LOCKED(locked),
	.CLKFBIN(loop),
	.CLKIN(extClk50),
	.RST(1'b0)
);

wire sysClk;

BUFG bufg(.O (sysClk), .I (clk100));

reg [26:0] counter = 0;

always @(posedge sysClk) begin
	counter <= (counter == 27'd99_999_999) ? 27'd0 : counter + 27'd1;
	led0 <= led0 ^ (counter == 27'd0);
end

assign led1 = !led0;

endmodule

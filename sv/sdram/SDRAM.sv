`default_nettype none

module SDRAM #(
	bankBits = 2,
	rowBits  = 13,
	colBits  = 9,
	dataBits = 16
) (
	input
		wire clk50,

	output
		wire LED0, LED1,

	output
		wire                SDRAM_CLK, SDRAM_CKE,
		wire [1:0]          SDRAM_DQM,
		wire                SDRAM_CSn, SDRAM_RASn, SDRAM_CASn, SDRAM_WEn,
		wire [bankBits-1:0] SDRAM_BA,
		wire [rowBits-1:0]  SDRAM_A,
	inout
		wire [dataBits-1:0] SDRAM_D
);
	localparam addrBits = bankBits+rowBits+colBits;

	logic [addrBits-1:0] addr;
	logic                r;
	logic                w;
	logic [dataBits-1:0] dw;
	wire  [dataBits-1:0] dr;
	wire                 busy;

	SDRAMC sdc (
		.clk(clk50), .addr, .r, .w, .dw, .dr, .busy,

		.CLK(SDRAM_CLK), .CKE(SDRAM_CKE),
		.CMD({SDRAM_CSn, SDRAM_RASn, SDRAM_CASn, SDRAM_WEn}),
		.BA(SDRAM_BA), .A(SDRAM_A), .D(SDRAM_D)
	);
endmodule;
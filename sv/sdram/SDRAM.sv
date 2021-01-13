`default_nettype none

module SDRAM #(
	bankBits = 2,
	rowBits  = 13,
	colBits  = 9,
	dataBits = 16,
) (
	output wire        LED0, LED1,

	output wire        SDRAM_CLK, SDRAM_CKE,
	output wire  [1:0] SDRAM_DQM,
	output wire        SDRAM_CSn, SDRAM_RASn, SDRAM_CASn, SDRAM_WEn,
	output wire [12:0] SDRAM_A,
	output wire [1:0]  SDRAM_BA,
	inout  wire [15:0] SDRAM_D
);
	param

	logic

	SDRAMC sdc (
		.CLK(SDRAM_CLK), .CKE(SDRAM_CKE),
		.CMD({SDRAM_CSn, SDRAM_RASn, SDRAM_CASn, SDRAM_WEn}),
		.BA(SDRAM_BA), .A(SDRAM_A), .D(SDRAM_D)
	);



endmodule;
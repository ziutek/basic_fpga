typedef struct packed {
	logic CSn, RASn, CASn, WEn;
} SDRAMCMD;

// SDRAMC implements a simple controller for 8, 16 and 32-bit SDR SDRAM.
// Default parameters correspond to a single MT48LC16M16A2 module.
module SDRAMC #(
	bankBits = 2,
	rowBits  = 13,
	colBits  = 9,
	dataBits = 16
) (
	// Interface
	input  clk,                                 // clock
	input  [bankBits+rowBits+colBits-1:0] addr, // address of data word
	input                                 r,    // start read transaction
	input                                 w,    // start write transaction
	input  [dataBits-1:0]                 dw,   // data input
	output [dataBits-1:0]                 dr,   // data output
	output                                busy, // busy flag

	// SDRAM signals
	output                CLK, // clock
	output                CKE, // clock enable
	output SDRAMCMD       CMD, // 4-bit command
	output [bankBits-1:0] BA,  // bank address
	output                A,   // row/column address
	inout                 D    // data bus
);

endmodule
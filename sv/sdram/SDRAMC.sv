`default_nettype none

typedef struct packed {
	logic CSn, RASn, CASn, WEn;
} SDRAMCmd;

// SDRAMC implements a simple controller for 8, 16 and 32-bit SDR SDRAM.
// Default parameters correspond to a single MT48LC16M16A2 module.
module SDRAMC #(
	bankBits = 2,
	rowBits  = 13,
	colBits  = 9,
	dataBits = 16,

	clkHz = 100_000_000,

	localparam addrBits = bankBits+rowBits+colBits
) (
	// Interface
	input  wire                 clk,  // clock
	input  wire  [addrBits-1:0] addr, // address of data word
	input  wire                 r,    // start read transaction
	input  wire                 w,    // start write transaction
	input  wire  [dataBits-1:0] dw,   // data input
	output logic [dataBits-1:0] dr,   // data output
	output logic                busy, // busy flag

	// SDRAM signals
	output wire                    CLK, // clock
	output logic                   CKE, // clock enable
	output SDRAMCmd                CMD, // 4-bit command
	output logic    [bankBits-1:0] BA,  // bank address
	output logic                   A,   // row/column address
	inout  wire                    D    // data bus
);

	localparam L = 1'b0, H = 1'b1;

	localparam SDRAMCmd
		cmdInhibit     = '{ H, L, L, L },
		cmdNOP         = '{ L, H, H, H },
		cmdActive      = '{ L, L, H, H },
		cmdAutoRefresh = '{ L, L, L, H },
		cmdLoadModeReg = '{ L, L, L, L },
		cmdPrecharge   = '{ L, L, H, L },
		cmdRead        = '{ L, H, L, H },
		cmdWrite       = '{ L, H, L, L },
		cmdTerminate   = '{ L, H, H, L };

	always_ff @(posedge clk) begin
		CMD <= cmdNOP;
	end


endmodule
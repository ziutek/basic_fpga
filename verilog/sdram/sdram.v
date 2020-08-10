`default_nettype none

module sdram(
	// interface
	input  clk,        // clock
	input  [23:0]addr, // address of 16-bit word
	inout  [15:0]data  // data I/O
	input  rd,         // start read transaction
	input  wr,         // write transaction
	output busy,       // busy

	// SDRAM signals
	output CLK,     // clock
	output CKE,     // clock enable
	output WEn,     // command bit 0
	output CASn,    // command bit 1
	output RASn,    // command bit 2
	output CSn,     // command bit 3
	output BA[1:0]  // bank address
	output A[12:0]  // address
	inout  DQ[15:0] // data
);

localparam cmdLoadMode  = 4'b0000; // load mode register
localparam cmdRefresh   = 4'b0001; // auto refresh
localparam cmdPrecharge = 4'b0010; // close row
localparam cmdActive    = 4'b0011; // select/open row
localparam cmdWrite     = 4'b0100; // select column and start write burst
localparam cmdRead      = 4'b0101; // select column and start read burst
localparam cmdTerminate = 4'b0110; // burst terminate
localparam cmdNop       = 4'b0111; // no operation
localparam cmdUnselect  = 4'b1000; // unselect chip (command inhibit)

endmodule
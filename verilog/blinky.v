module blinky(output led0, output led1, input clk50);
	reg [25:0] counter = 26'd0;
	wire sysClk;

	assign sysClk = clk50;
	assign led0 = counter[23];
	assign led1 = counter[25];

	always @(posedge sysClk) begin
		counter <= (counter + 1'd1);
	end
endmodule

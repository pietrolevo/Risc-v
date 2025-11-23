///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: PC.v
// Description: implementation of a simple Program Counter 
///////////////////////////////////////////////////////////////////////////

module PC (clk, rst, pcIn, pcOut);
	input		clk;
	input		rst;
	input		[31:0] pcIn;
	output	reg [31:0] pcOut;

	always @(posedge clk)
	begin
		if (rst) begin
			pcOut <= 32'b0;
		end else begin
			pcOut <= pcIn;
		end
	end
	
endmodule
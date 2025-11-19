///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: PC.v
// Description: implementation of a simple Program Counter 
///////////////////////////////////////////////////////////////////////////

module PC (clk, rst, pc_in, pc_out);
	input		clk;
	input		rst;
	input		[31:0] pc_in;
	output	reg [31:0] pc_out;

	always @(posedge clk)
	begin
		if (rst) begin
			pc_out <= 32'b0;
		end else begin
			pc_out <= pc_in;
		end
	end
endmodule
///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: mux2to1.v
// Description: implementation of a 2 to 1 multiplexer
///////////////////////////////////////////////////////////////////////////

module mux2to1(i0, i1, sel, o);
	input 	sel;
	input		[31:0] i0, i1;
	output	reg [31:0] o;
	
	always @(*)
	begin
		if (sel) begin
			o = i1;
		end else begin
			o = i0;
		end
	end
	
endmodule

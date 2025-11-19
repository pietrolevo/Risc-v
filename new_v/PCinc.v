///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: PCinc.v
// Description: implementation of the PC incrementer (adder of 4) 
///////////////////////////////////////////////////////////////////////////

module PCinc (pc_out, pc_new);
	input		[31:0] pc_out;
	output	[31:0] pc_new;
	
	assign pc_new = pc_out + 4;
endmodule
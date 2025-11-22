///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: executeModule.v
// Description: implementation of the execute submodule
///////////////////////////////////////////////////////////////////////////

module executeModule (data1, data2, imm, pc_out, sel, alu_ctrl, zero, mux1in, alu_res);
	input		[31:0]data1, data2, imm, pc_out;
	input		[3:0]alu_ctrl;
	input		sel;
	output	zero;
	output	[31:0]mux1in, alu_res;

	wire [31:0] alu_in1;
	
	adder address_calculation (
		.in0 (pc_out),
		.in1 (imm),
		.res (mux1in)
	);
	
	mux2to1 mux2(
		.i0 (data2), 
		.i1 (imm), 
		.sel (sel), 
		.o (alu_in1)
	);

	ALU alu_unit(
		.in0 (data1),
		.in1 (alu_in1), 
		.alu_ctrl (alu_ctrl), 
		.zero_flag (zero), 
		.alu_res (alu_res)
	);

endmodule
///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: executeModule.v
// Description: implementation of the execute submodule
///////////////////////////////////////////////////////////////////////////

module executeModule (data1, data2, imm, pcOut, sel, aluCtrl, zero, mux1In, aluRes);
	input		[31:0]data1, data2, imm, pcOut;
	input		[3:0]aluCtrl;
	input		sel;
	output	zero;
	output	[31:0]mux1In, aluRes;

	wire [31:0] alu_in1;
	
	adder address_calculation (
		.in0 (pcOut),
		.in1 (imm),
		.res (mux1In)
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
		.aluCtrl (aluCtrl), 
		.zeroFlag (zero), 
		.aluRes (aluRes)
	);

endmodule
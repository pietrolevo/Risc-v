///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: fetchModule.v
// Description: implementation fetch submodule
///////////////////////////////////////////////////////////////////////////

module fetchModule (clk, rst, mux1Sel, mux1In, pcOut, instrOut);	//at the moment only one rst for all
	input		clk;
	input		rst;
	input 	mux1Sel;
	input		[31:0] mux1In;
	output	[31:0] pcOut, instrOut;
		
	wire		[31:0] npc_s;
	wire		[31:0] mux1Out;
	wire		[31:0] pcOut_s;
	
	mux2to1 mux1 (
		.i0 (npc_s),
		.i1 (mux1In),
		.sel (mux1Sel),
		.o (mux1Out)
	);
	
	PC program_counter(
		.clk (clk),
		.rst (rst),
		.pcIn (mux1Out),
		.pcOut (pcOut_s)
	);
	
	PCinc pc_adder (
		.pcOut (pcOut_s),
		.pcNew (npc_s)
	);
	
	InstrMem instruction_memory(
	.clk (clk),
	.rst (rst),
	.addrIn (pcOut_s),
	.instrOut (instrOut)
	);
	
	assign pcOut = pcOut_s;
	
endmodule
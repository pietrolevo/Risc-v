///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: fetchModule.v
// Description: implementation fetch submodule
///////////////////////////////////////////////////////////////////////////

module fetchModule (clk, rst, mux1sel, pc_next, instro);	//at the moment only one rst for all
	input		clk;
	input		rst;
	input 	mux1sel;
	input		[31:0] pc_next;
	output	[31:0] instro;
		
	wire		[31:0] muxin0;
	wire		[31:0] mux1o;
	wire		[31:0] pc_out_s;
	
	mux2to1 mux1 (
		.i0 (muxin0),
		.i1(pc_next),
		.sel (mux1sel),
		.o (mux1o)
	);
	
	PC program_counter(
		.clk (clk),
		.rst (rst),
		.pc_in (mux1o),
		.pc_out (pc_out_s)
	);
	
	PCinc pc_adder (
		.pc_out (pc_out_s),
		.pc_new (muxin0)
	);
	
	InstrMem instruction_memory(
	.clk (clk),
	.rst (rst),
	.addri (pc_out_s),
	.instro (instro)
	);
	
endmodule
///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: Core.v
// Description: implementation of core datapath
///////////////////////////////////////////////////////////////////////////

// at the moment there is no control unit so the signal are inputs of the core

module Core (clk, rst, mux1Sel, mux2Sel, mux3Sel,
	regWrite, memWrite, memRead, aluCtrl, zero);
	
	input		clk, rst;
	input		mux1Sel, mux2Sel, mux3Sel;
	input		regWrite, memWrite, memRead, aluCtrl;
	output	zero;

	wire [31:0] instro_s;
	wire [31:0] d1, d2;
	wire [31:0] imm;
	wire [31:0] wb;
	wire [31:0] mux1In_s;
	wire [31:0] alu_out_s;
	wire [31:0] mem_out;
	wire [31:0] mux1in_s;
	wire [31:0] pc_out_s;

	fetchModule F (
		.clk (clk), 
		.rst (rst), 
		.mux1Sel (mux1Sel), 
		.mux1In (mux1in_s), 
		.pcOut (pc_out_s),
		.instrOut (instro_s)
	);
	
	decodeModule D (
		.clk (clk), 
		.instrIn (instro_s), 
		.writeCmd (regWrite), 
		.wBack (wb), 
		.data1 (d1), 
		.data2 (d2), 
		.immediate (imm)
	);
	
	executeModule E (
		.data1 (d1), 
		.data2 (d2), 
		.imm (imm), 
		.pcOut (pc_out_s), 
		.sel (mux2Sel), 
		.aluCtrl (aluCtrl), 
		.zero (zero), 
		.mux1In (mux1in_s), 
		.aluRes (alu_out_s)
	);
	
	DataMem MEM(
		.clk (clk), 
		.memWrite (memWrite), 
		.memRead (memRead), 
		.addrIn (alu_out_s), 
		.writeData (d2), 
		.readData (mem_out)
	);
	
	mux2to1 WRB (
		.i0 (alu_out_s), 
		.i1 (mem_out), 
		.sel (mux3Sel), 
		.o (wb)
	);
				
endmodule
///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: InstrMem.v
// Description: implementation of an Instruction Memory
///////////////////////////////////////////////////////////////////////////

module InstrMem (clk, rst, addri, instro);
	input		clk;
	input		rst;
	input		[31:0] addri;
	output	reg[31:0] instro;
	
	reg[31:0] mem[0:255];
	
	initial begin
		$readmemh("program.hex", mem);
	end
	
	always @(posedge clk)
	begin
		if (rst) begin
			instro <= mem[0];
		end else begin
			instro <= mem[addri[9:2]];
		end
	end
endmodule
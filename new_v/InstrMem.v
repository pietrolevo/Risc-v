///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: InstrMem.v
// Description: implementation of an Instruction Memory
///////////////////////////////////////////////////////////////////////////

module InstrMem (clk, rst, addrIn, instrOut);
	input		clk;
	input		rst;
	input		[31:0] addrIn;
	output	reg[31:0] instrOut;
	
	reg[31:0] mem[0:255];
	
	initial begin
		$readmemh("program.hex", mem);
	end
	
	always @(posedge clk)
	begin
		if (rst) begin
			instrOut <= mem[0];
		end else begin
			instrOut <= mem[addrIn[9:2]];
		end
	end
endmodule
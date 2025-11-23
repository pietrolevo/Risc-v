///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: Registers.v
// Description: implementation of the Registers
///////////////////////////////////////////////////////////////////////////

module Registers (clk, regWrite, read1, read2, writeReg, writeData,
						data1, data2);
	input 	clk;
	input		regWrite;
	input 	[4:0]read1, read2, writeReg;
	input		[31:0]writeData;
	output	[31:0]data1, data2;

	reg [31:0]regFile [31:0];
	
	assign data1 = regFile[read1];
	assign data2 = regFile[read2];
	
	always @(posedge clk)
	begin
		if (regWrite) begin
			regFile[writeReg] <= writeData;
		end
	end
endmodule
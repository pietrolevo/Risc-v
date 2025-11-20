///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: Registers.v
// Description: implementation of the Registers
///////////////////////////////////////////////////////////////////////////

module Registers (clk, regwrite, read1, read2, writeReg, writeData,
						data1, data2);
	input 	clk;
	input		regwrite;
	input 	[4:0]read1, read2, writeReg;
	input		[31:0]writeData;
	output	[31:0]data1, data2;

	reg [31:0]RF [31:0];
	
	assign data1 = RF[read1];
	assign data2 = RF[read2];
	
	always @(posedge clk)
	begin
		if (regwrite) begin
			RF[writeReg] <= writeData;
		end
	end
endmodule
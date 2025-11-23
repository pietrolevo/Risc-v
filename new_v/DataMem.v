///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: DataMem.v
// Description: implementation of a simple Data Memory
///////////////////////////////////////////////////////////////////////////

module DataMem (clk, memWrite, memRead, addrIn, writeData, readData);
	input		clk, memWrite, memRead;
	input		[31:0]addrIn;
	input		[31:0]writeData;
	output	[31:0]readData;
	
	reg [31:0]mem [0:1023];
	reg [31:0]readData_s;
	
	always @(posedge clk)
	begin
		if (memWrite == 1 && memRead == 0) begin
			mem[addrIn[11:2]] <= writeData;
		end else if (memWrite == 0 && memRead == 1) begin
			readData_s <= mem[addrIn[11:2]];
		end
	end
	
	assign readData = readData_s;

endmodule
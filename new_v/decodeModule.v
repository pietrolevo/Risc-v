///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: DecodeModule.v
// Description: implementation of the Decode submodule
///////////////////////////////////////////////////////////////////////////

module decodeModule(clk, instrIn, writeCmd, wBack, data1, data2, immediate);
	input		clk;
	input		writeCmd;
	input		[31:0]instrIn, wBack;
	output	[31:0]data1, data2, immediate;

	
	
	Registers registers_file (
		.clk (clk),
		.regWrite (writeCmd), 
		.read1 (instrIn[19:15]),
		.read2 (instrIn[24:20]),
		.writeReg (instrIn[11:7]),
		.writeData (wBack),
		.data1 (data1),
		.data2 (data2)
	);
	
	ImmGen immediate_generator (
		.instrIn (instrIn),
		.imm (immediate)
	);
endmodule
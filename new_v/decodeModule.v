///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: DecodeModule.v
// Description: implementation of the Decode submodule
///////////////////////////////////////////////////////////////////////////

module decodeModule(clk, instri, writecmd, wback, data1, data2, immediate);
	input		clk;
	input		writecmd;
	input		[31:0]instri, wback;
	output	[31:0]data1, data2, immediate;

	
	
	Registers registers_file (
		.clk (clk),
		.regwrite (writecmd), 
		.read1 (instri[19:15]),
		.read2 (instri[24:20]),
		.writeReg (instri[11:7]),
		.writeData (wback),
		.data1 (data1),
		.data2 (data2)
	);
	
	ImmGen immediate_generator (
			.instri (instri),
			.imm (immediate)
		);
endmodule
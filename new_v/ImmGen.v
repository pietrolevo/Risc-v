///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: ImmGen.v
// Description: implementation of immediate generator 
///////////////////////////////////////////////////////////////////////////

// check again later, especially for SB-type and UJ type
module ImmGen (instri,imm);

input  [31:0] instri;
output [31:0] imm;

wire [6:0] opcode = instri[6:0];

assign imm =
	//I-type
	(opcode == 7'b0000011 || opcode == 7'b0010011 || opcode == 7'b1100111) ?
	{{20{instri[31]}}, instri[31:20]} :

	//S-type
	(opcode == 7'b0100011) ?
	{{20{instri[31]}}, instri[31:25], instri[11:7]} :

	//SB-type
	(opcode == 7'b1100011) ?
	{{19{instri[31]}}, instri[31], instri[7], instri[30:25], instri[11:8], 1'b0} :

	//U-type
	(opcode == 7'b0110111 || opcode == 7'b0010111) ?
	{instri[31:12], 12'b0} :

	//UJ-type
	(opcode == 7'b1101111) ?
	{{11{instri[31]}}, instri[31], instri[19:12], instri[20], instri[30:21], 1'b0} :

	32'b0;

endmodule
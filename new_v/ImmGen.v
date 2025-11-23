///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: ImmGen.v
// Description: implementation of immediate generator 
///////////////////////////////////////////////////////////////////////////

// check again later, especially for SB-type and UJ type
module ImmGen (instrIn,imm);

	input  [31:0] instrIn;
	output [31:0] imm;

	wire [6:0] opcode = instrIn[6:0];

	assign imm =
		//I-type
		(opcode == 7'b0000011 || opcode == 7'b0010011 || opcode == 7'b1100111) ?
		{{20{instrIn[31]}}, instrIn[31:20]} :

		//S-type
		(opcode == 7'b0100011) ?
		{{20{instrIn[31]}}, instrIn[31:25], instrIn[11:7]} :

		//SB-type
		(opcode == 7'b1100011) ?
		{{19{instrIn[31]}}, instrIn[31], instrIn[7], instrIn[30:25], instrIn[11:8], 1'b0} :

		//U-type
		(opcode == 7'b0110111 || opcode == 7'b0010111) ?
		{instrIn[31:12], 12'b0} :

		//UJ-type
		(opcode == 7'b1101111) ?
		{{11{instrIn[31]}}, instrIn[31], instrIn[19:12], instrIn[20], instrIn[30:21], 1'b0} :

		32'b0;

endmodule
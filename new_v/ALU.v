///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: ALU.v
// Description: implementation of a simple generic ALU
///////////////////////////////////////////////////////////////////////////

// need big modifications when the control unit will be available

module ALU (in0, in1, aluCtrl, zeroFlag, aluRes);
	input		[31:0]in0, in1;
	input		[3:0]aluCtrl;
	output	zeroFlag;
	output	reg[31:0]aluRes;
	
	always @(*)
	begin
		case (aluCtrl)
			4'b0000: aluRes = in0 + in1;
			4'b0001: aluRes = in0 - in1;
			4'b0010: aluRes = in0 & in1;
			4'b0011: aluRes = in0 | in1;
			4'b0100: aluRes = in0 ^ in1;
			4'b0101: aluRes = in0 < in1 ? 1 : 0;
			default: aluRes = 32'b0;
		endcase
	end
	
	assign zeroFlag = (aluRes == 0);
endmodule
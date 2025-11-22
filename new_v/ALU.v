///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: ALU.v
// Description: implementation of a simple generic ALU
///////////////////////////////////////////////////////////////////////////

// need big modifications when the control unit will be available

module ALU (in0, in1, alu_ctrl, zero_flag, alu_res);
	input		[31:0]in0, in1;
	input		[3:0]alu_ctrl;
	output	zero_flag;
	output	reg[31:0]alu_res;
	
	always @(*)
	begin
		case (alu_ctrl)
			4'b0000: alu_res <= in0 + in1;
			4'b0001: alu_res <= in0 - in1;
			4'b0010: alu_res <= in0 & in1;
			4'b0011: alu_res <= in0 | in1;
			4'b0100: alu_res <= in0 ^ in1;
			4'b0101: alu_res <= in0 < in1 ? 1 : 0;
			default: alu_res <= 32'b0;
		endcase
	end
	
	assign zero_flag = (alu_res == 0);
endmodule
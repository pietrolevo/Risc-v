///////////////////////////////////////////////////////////////////////////
// Engineer: Pietro Alberto Levo
// File: ControlUnit.v
// Description: implementation of simple control unit
///////////////////////////////////////////////////////////////////////////

module ControlUnit (
	input 	clk,
	input		rst,
	input		[6:0]opcode,
	output	reg branch,
	output	reg memRead,
	output	reg memToReg,
	output	reg [3:0]aluCtrl,
	output	reg memWrite,
	output	reg aluSrc,
	output	reg regWrite
);

	localparam IF = 3'b000,
					ID = 3'b001,
					EX = 3'b010,
					MEM = 3'b011,
					WB = 3'b100;
	
	reg[2:0] state, nextState;
	
	always@(posedge clk)
	begin
		if (rst) begin
			state <= IF;
		end else begin
			state <= nextState;
		end
	end

	always@(*)
	begin
		case(state)
			IF: nextState = ID;
			ID: case(opcode)
				7'b0110011: nextState = EX;
				7'b0000011: nextState = EX;
				7'b0100011: nextState = EX;
				7'b1100111: nextState = EX;
				default: nextState = IF;
			endcase
			EX: case(opcode)
			  7'b0000011: nextState = MEM;
			  7'b0100011: nextState = MEM;
			  7'b0110011: nextState = WB;
			  7'b1100011: nextState = IF;
			  default:    nextState = IF;
			endcase
			MEM: case(opcode)
			  7'b0000011: nextState = WB;
			  7'b0100011: nextState = IF;
			  default:    nextState = IF;
			endcase
			WB: nextState = IF;
            default: nextState = IF;
		endcase
	end
	
	always @(*) begin
		branch   = 0;
		memRead  = 0;
		memToReg = 0;
		aluCtrl  = 4'b0000;
		memWrite = 0;
		aluSrc   = 0;
		regWrite = 0;

		case(state)
			EX: begin
				case(opcode)
				7'b0110011: aluCtrl = 4'bxxxx;
				7'b0000011: begin aluCtrl = 4'b0000; aluSrc=1; end
				7'b0100011: begin aluCtrl = 4'b0000; aluSrc=1; end
				7'b1100011: begin aluCtrl = 4'b0001; branch=1; end
				endcase
			end
			
			MEM: begin
			if(opcode==7'b0000011) memRead=1;
			else if(opcode==7'b0100011) memWrite=1;
			end
			
			WB: begin
			regWrite=1;
			if(opcode==7'b0000011) memToReg=1;
			end
		endcase
	end

endmodule
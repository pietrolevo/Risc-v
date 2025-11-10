--------------------------------------------------------------------------
-- Author: Pietro Alberto Levo
-- File : ALU.vhd 
-- entity: ALU
-- Architecture: RTL 
-- function: source file for a simple risc-v ALU
--------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ALU IS 
	PORT(
		op1: IN std_logic_vector(31 DOWNTO 0);
		op2: IN std_logic_vector(31 DOWNTO 0);
		ctrl: IN std_logic_vector(3 DOWNTO 0);
		res: OUT std_logic_vector(31 DOWNTO 0);
		zero: OUT std_logic
	);
END ALU;

ARCHITECTURE RTL OF ALU IS
	SIGNAL res_s: std_logic_vector(31 DOWNTO 0);
	
    CONSTANT ALU_ADD:  std_logic_vector(3 DOWNTO 0) := "0000";
    CONSTANT ALU_SUB:  std_logic_vector(3 DOWNTO 0) := "0001";
    CONSTANT ALU_AND:  std_logic_vector(3 DOWNTO 0) := "0010";
    CONSTANT ALU_OR:   std_logic_vector(3 DOWNTO 0) := "0011";
    CONSTANT ALU_XOR:  std_logic_vector(3 DOWNTO 0) := "0100";
BEGIN
CombLogic: PROCESS(op1, op2, ctrl)
	BEGIN
		CASE (ctrl) IS
			WHEN ALU_ADD =>
				res_s <= std_logic_vector(signed(op1) + signed(op2));
			WHEN ALU_SUB =>
				res_s <= std_logic_vector(signed(op1) - signed(op2));
			WHEN ALU_XOR =>
				res_s <= op1 XOR op2;
			WHEN ALU_OR =>
				res_s <= op1 OR op2;
			WHEN ALU_AND =>
				res_s <= op1 AND op2;
			WHEN OTHERS =>
				res_s <= (OTHERS => '0');
		END CASE;
		
		IF res_s = x"00000000" THEN
			zero <= '1';
		ELSE 
			zero <= '0';
		END IF;
	END PROCESS;
	res <= res_s;
END RTL;
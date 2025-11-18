--------------------------------------------------------------------------
-- Author: Pietro Alberto Levo
-- File : alu_tb.hd 
-- entity: alu_tb 
-- Architecture: TBarch 
-- function: testbench for risc-v ALU.vhd
--------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY alu_tb IS
END alu_tb;

ARCHITECTURE TBarch OF alu_tb IS
COMPONENT ALU IS
	PORT(
		op1: IN std_logic_vector(31 DOWNTO 0);
		op2: IN std_logic_vector(31 DOWNTO 0);
		ctrl: IN std_logic_vector(9 DOWNTO 0);
		res: OUT std_logic_vector(31 DOWNTO 0);
		zero: OUT std_logic
	);
END COMPONENT;

SIGNAL op1, op2: std_logic_vector(31 DOWNTO 0);
SIGNAL ctrl: std_logic_vector(9 DOWNTO 0);
SIGNAL res: std_logic_vector(31 DOWNTO 0);
SIGNAL zero: std_logic;

BEGIN
	DUT: ALU PORT MAP(op1 => op1, op2 => op2, ctrl => ctrl, res => res, zero => zero);
	PROCESS
	BEGIN
		op1 <= x"00000005";
		op2 <= x"00000003";
		ctrl <= "0000000000";
		WAIT FOR 10 ns;
		ASSERT res = x"00000008"
			REPORT "ADD failed: expected 8";
			
		op1 <= x"00000005";
		op2 <= x"00000003";
		ctrl <= "0000100000";
		WAIT FOR 10 ns;
		ASSERT res = x"00000002"
			REPORT "SUB failed: expected 2";
			
		op1 <= x"00000003";
		op2 <= x"00000005";
		ctrl <= "0000100000";
		WAIT FOR 10 ns;
		ASSERT res = x"FFFFFFFE"
			REPORT "SUB failed: expected 2";
			
		op1 <= x"00000003";
		op2 <= x"00000005";
		ctrl <= "1111111111";
		WAIT FOR 10 ns;
		ASSERT res = x"FFFFFFFE"
			REPORT "SUB failed: expected 2";
	WAIT;
	END PROCESS;
END TBarch;
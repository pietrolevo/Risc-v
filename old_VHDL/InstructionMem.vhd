--------------------------------------------------------------------------
-- Author: Pietro Alberto Levo
-- File : InstructionMem.vhd 
-- entity: InstructionMem
-- Architecture: RTL 
-- function: source file for the instruction memory
--------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY InstructionMem IS
    PORT(
        ReadAddress: IN std_logic_vector(31 DOWNTO 0);
        Instruction: OUT std_logic_vector(31 DOWNTO 0)
    );
END InstructionMem;

ARCHITECTURE RTL OF InstructionMem IS
    SIGNAL Instr_s: std_logic_vector(31 DOWNTO 0);
    TYPE reg_array IS ARRAY(0 TO 255) OF std_logic_vector(31 DOWNTO 0);
    SIGNAL InstrMem: reg_array := (OTHERS => x"00000033");
BEGIN
    CombLogic: PROCESS(ReadAddress)
    BEGIN
        Instr_s <= InstrMem(to_integer(unsigned(ReadAddress(9 DOWNTO 2))));
    END PROCESS;
    Instruction <= Instr_s;
END RTL;
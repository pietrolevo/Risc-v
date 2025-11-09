--------------------------------------------------------------------------
-- Author: Pietro Alberto Levo
-- File : ProgramCounter.vhd 
-- entity: ProgramCounter 
-- Architecture: RTL 
-- function: source file for the program counter
--------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ProgramCounter IS
    PORT(
        clk: IN std_logic;
        reset: IN std_logic;
        PC_in: IN std_logic_vector(31 DOWNTO 0);
        PC_out: OUT std_logic_vector(31 DOWNTO 0)
    );
END ProgramCounter;

ARCHITECTURE RTL OF ProgramCounter IS
    SIGNAL pc_out_s: std_logic_vector(31 DOWNTO 0);
BEGIN
    SeqLogic: PROCESS(clk, reset)
    BEGIN
        IF reset = '1' THEN
            pc_out_s <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            pc_out_s <= PC_in;
        END IF;
    END PROCESS;
    PC_out <= pc_out_s; 
END RTL;
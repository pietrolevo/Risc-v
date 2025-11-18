--------------------------------------------------------------------------
-- Author: Pietro Alberto Levo
-- File : PC_add.vhd 
-- entity: PC_add 
-- Architecture: RTL 
-- function: source file for the program counter incrementer
--------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY PC_add IS
    PORT(
        PC_addr: IN std_logic_vector(31 DOWNTO 0);
        res: OUT std_logic_vector(31 DOWNTO 0) 
    );
END PC_add;

ARCHITECTURE RTL OF PC_add IS
    SIGNAL res_s: std_logic_vector(31 DOWNTO 0);
BEGIN
    CombLogic: PROCESS(PC_addr)
    BEGIN
        res_s <= std_logic_vector(unsigned(PC_addr) + 4);
    END PROCESS;
    res <= res_s;
END RTL;
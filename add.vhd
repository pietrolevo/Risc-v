--------------------------------------------------------------------------
-- Author: Pietro Alberto Levo
-- File : add.vhd
-- entity: add
-- Architecture: RTL
-- function: Immediate Generator I, S, B Types
--------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY add IS
    PORT(
        A: IN std_logic_vector(31 DOWNTO 0);
        B: IN std_Logic_vector(31 DOWNTO 0);
        y: OUT std_logic_vector(31 DOWNTO 0)
    );
END add;

ARCHITECTURE RTL OF add IS
    SIGNAL y_s: std_logic_vector(31 DOWNTO 0);
BEGIN
    PROCESS(A, B)
    BEGIN
        y_s <= std_logic_vector(unsigned(A) + unsigned(B));
    END PROCESS;
    y <= y_s;
END RTL;
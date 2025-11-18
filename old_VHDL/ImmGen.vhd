--------------------------------------------------------------------------
-- Author: Pietro Alberto Levo
-- File : ImmGen.vhd
-- entity: ImmGen
-- Architecture: RTL
-- function: Immediate Generator I, S, B Types
--------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ImmGen IS
    PORT(
        instruction: IN std_logic_vector(31 DOWNTO 0);
        sel: IN std_logic_vector(1 DOWNTO 0);
        result:      OUT std_logic_vector(31 DOWNTO 0)
    );
END ImmGen;

ARCHITECTURE RTL OF ImmGen IS
    
    SIGNAL imm_I : std_logic_vector(31 DOWNTO 0);
    SIGNAL imm_S : std_logic_vector(31 DOWNTO 0);
    SIGNAL imm_B : std_logic_vector(31 DOWNTO 0);
BEGIN
    imm_I <= (
        (31 DOWNTO 12 => instruction(31)) & instruction(31 DOWNTO 20)
    );

    imm_S <= (
        (31 DOWNTO 12 => instruction(31)) & instruction(31 DOWNTO 25) &
        instruction(11 DOWNTO 7)
    );

    imm_B <= (
        (31 DOWNTO 13 => instruction(31)) & instruction(31) &
        instruction(7) & instruction(30 DOWNTO 25) & 
        instruction(11 DOWNTO 8) & '0'
    );

    WITH sel SELECT
        result <= imm_I WHEN "00",
                  imm_S WHEN "01",
                  imm_B WHEN "10",
                  (OTHERS => 'X') WHEN OTHERS;
END RTL;
--------------------------------------------------------------------------
-- Author: Pietro Alberto Levo
-- File : myMux.vhd 
-- entity: myMux
-- Architecture: RTL 
-- function: source file for a 2x1 multiplexer 
--------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY myMux IS
    PORT(
        A: IN std_logic_vector(31 DOWNTO 0);
        B: IN std_logic_vector(31 DOWNTO 0);
        sel: IN std_logic;
        y: OUT std_logic_vector(31 DOWNTO 0)
    );
END myMux;

ARCHITECTURE RTL OF myMux IS
    SIGNAL y_s: std_logic_vector(31 DOWNTO 0);
BEGIN
    CombLogic: PROCESS(A, B, sel)
    BEGIN
        CASE (sel) IS
            WHEN '0' => 
                y_s <= A;
            WHEN '1' =>
                y_s <= B;
            WHEN OTHERS =>
                y_s <= (OTHERS => '0');
        END CASE;
    END PROCESS;
    y <= y_s;
END RTL;
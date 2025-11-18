--------------------------------------------------------------------------
-- Author: Pietro Alberto Levo
-- File : myAnd.vhd 
-- entity: myAnd
-- Architecture: Beh
-- function: source file for and gate 
--------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY myAnd IS
    PORT(
        A, B: IN std_logic;
        y: OUT std_logic
    );
END myAnd;

ARCHITECTURE Beh OF myAnd IS
BEGIN
    PROCESS
    BEGIN
        y <= A AND B;
    END PROCESS;
END Beh;
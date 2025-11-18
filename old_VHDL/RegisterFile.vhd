--------------------------------------------------------------------------
-- Author: Pietro Alberto Levo
-- File : RegisterFile.vhd 
-- entity: RegisterFile 
-- Architecture: RTL 
-- function: source file for the Register File
--------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY RegisterFile IS
    PORT(
        clk: IN std_logic;
        RegWrite: IN std_logic;
        ReadReg1: IN std_logic_vector(4 DOWNTO 0);
        ReadReg2: IN std_logic_vector(4 DOWNTO 0);
        WriteReg: IN std_logic_vector(4 DOWNTO 0);
        WriteData: IN std_logic_vector(31 DOWNTO 0);
        ReadData1: OUT std_logic_vector(31 DOWNTO 0);
        ReadData2: OUT std_logic_vector(31 DOWNTO 0)
    );
END RegisterFile;

ARCHITECTURE RTL OF RegisterFile IS
    SIGNAL rd1_s, rd2_s: std_logic_vector(31 DOWNTO 0);
    TYPE reg_array IS ARRAY(0 TO 31) OF std_logic_vector(31 DOWNTO 0);
    SIGNAL Regs: reg_array;
BEGIN
    CombLogic: PROCESS(ReadReg1, ReadReg2, Regs)
    BEGIN
        rd1_s <= Regs(to_integer(unsigned(ReadReg1)));
        rd2_s <= Regs(to_integer(unsigned(ReadReg2)));
    END PROCESS;
    
    SeqLogic: PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN 
            IF RegWrite = '1' THEN
                Regs(to_integer(unsigned(WriteReg))) <= WriteData;
            END IF;
        END IF;
    END PROCESS;
    ReadData1 <= rd1_s;
    ReadData2 <= rd2_s;
END RTL;
--------------------------------------------------------------------------
-- Author: Pietro Alberto Levo
-- File : DataMem.vhd 
-- entity: DataMem
-- Architecture: RTL 
-- function: source file for the data memory unit 
--------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY DataMem IS
    PORT(
        clk: IN std_Logic;
        MemWrite: IN std_logic;
        MemRead: IN std_logic;
        address: IN std_Logic_vector(31 DOWNTO 0);
        WriteData: IN std_logic_vector(31 DOWNTO 0);
        ReadData: OUT std_Logic_vector(31 DOWNTO 0)
    );
END DataMem;

ARCHITECTURE RTL OF DataMem IS
    SIGNAL readdata_s: std_logic_vector(31 DOWNTO 0);
    TYPE mem_array IS ARRAY(0 TO 255) OF std_logic_vector(31 DOWNTO 0);
    SIGNAL dmem: mem_array;
    SIGNAL read_bus: std_logic_vector(31 DOWNTO 0);
    SIGNAL addr_index : integer range 0 to 255;
BEGIN
    addr_index <= to_integer(unsigned(address(7 DOWNTO 0)));
    SeqLogic: PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF MemWrite = '1' THEN
                dmem(addr_index) <= WriteData;
            END IF;
        END IF;
    END PROCESS;
    read_bus <= dmem(addr_index);
    ReadData <= read_bus WHEN MemRead = '1' ELSE
                (OTHERS => 'Z');
END RTL;
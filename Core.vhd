--------------------------------------------------------------------------
-- Author: Pietro Alberto Levo
-- File : Core.vhd 
-- entity: Core 
-- Architecture: Structural 
-- function: source file for the core
--------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Core IS 
    PORT(
        clk: IN std_logic;
        reset: IN std_logic
    );
END Core;

ARCHITECTURE Struct OF Core IS
    COMPONENT ProgramCounter IS
        PORT(
            clk: IN std_logic;
            reset: IN std_logic;
            PC_in: IN std_logic_vector(31 DOWNTO 0);
            PC_out: OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT PC_add IS
        PORT(
            PC_addr: IN std_logic_vector(31 DOWNTO 0);
            res: OUT std_logic_vector(31 DOWNTO 0) 
        );
    END COMPONENT;
    
    COMPONENT InstructionMem IS
        PORT(
            ReadAddress: IN std_logic_vector(31 DOWNTO 0);
            Instruction: OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;
    
    SIGNAL new_pc: std_logic_vector(31 DOWNTO 0);
    SIGNAL pc_out_s: std_logic_vector(31 DOWNTO 0);
    SIGNAL instr: std_logic_vector(31 DOWNTO 0);
    
BEGIN
    progcnt: ProgramCounter 
        PORT MAP(clk => clk, reset => reset, PC_in => new_pc, PC_out => pc_out_s);

    incr: PC_add
        PORT MAP(PC_addr => pc_out_s, res => new_pc);
        
    inmem: InstructionMem
        PORT MAP(ReadAddress => pc_out_s, Instruction => instr);
END Struct;
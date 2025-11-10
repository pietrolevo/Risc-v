--------------------------------------------------------------------------
-- Author: Pietro Alberto Levo
-- File : ControlUnit.vhd 
-- entity: ControlUnit
-- Architecture: RTL 
-- function: source file for a simple riscv core control unit
--------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ControlUnit IS
    PORT(
        opcode: IN  std_logic_vector(6 DOWNTO 0);
        Branch: OUT std_logic;
        MemRead: OUT std_logic;
        MemToReg: OUT std_logic;
        ALUOp: OUT std_logic_vector(1 DOWNTO 0);
        MemWrite: OUT std_logic;
        ALUSrc: OUT std_logic;
        RegWrite: OUT std_logic;
        immsel: OUT std_logic_vector(1 DOWNTO 0)
    );
END ControlUnit;

ARCHITECTURE RTL OF ControlUnit IS
BEGIN
    ControlLogic: PROCESS(opcode)
    BEGIN
        Branch   <= '0';
        MemRead  <= '0';
        MemToReg <= '0';
        ALUOp    <= "00";
        MemWrite <= '0';
        ALUSrc   <= '0';
        RegWrite <= '0';
        immsel <= "00";

        CASE opcode IS
            
            -- R-TYPE
            WHEN "0110011" =>
                Branch   <= '0';
                MemRead  <= '0';
                MemToReg <= '0';
                ALUOp    <= "10";
                MemWrite <= '0';
                ALUSrc   <= '0';
                RegWrite <= '1';
                immsel <= "00";
                
            -- LOAD
            WHEN "0000011" =>
                Branch   <= '0';
                MemRead  <= '1';    
                MemToReg <= '1';    
                ALUOp    <= "00";
                MemWrite <= '0';
                ALUSrc   <= '1';
                RegWrite <= '1';
                immsel <= "01";
                immsel <= "00";
                
            -- STORE
            WHEN "0100011" =>
                Branch   <= '0';
                MemRead  <= '0';
                MemToReg <= '0';
                ALUOp    <= "00";
                MemWrite <= '1'; 
                ALUSrc   <= '1';
                RegWrite <= '0';
                immsel <= "01";
                
            -- BRANCH
            WHEN "1100011" =>
                Branch   <= '1';    
                MemRead  <= '0';
                MemToReg <= '0';
                ALUOp    <= "01";   
                MemWrite <= '0';
                ALUSrc   <= '0';
                RegWrite <= '0';
                immsel <= "10";
            
            -- IMMEDIATE
            WHEN "0010011" =>
                Branch   <= '0';
                MemRead  <= '0';
                MemToReg <= '0';
                ALUOp    <= "11";
                MemWrite <= '0';
                ALUSrc   <= '1'; 
                RegWrite <= '1';
                immsel <= "00";

            WHEN OTHERS =>
                NULL;   
        END CASE;
    END PROCESS;
END RTL;
--------------------------------------------------------------------------
-- Author: Pietro Alberto Levo
-- File : aluControl.vhd 
-- entity: aluControl 
-- Architecture: RTL 
-- function: source file for the alu control
--------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY aluControl IS
    PORT(
        ALUOp: IN std_logic_vector(1 DOWNTO 0);
        funct7: IN std_logic_vector(6 DOWNTO 0);
        funct3: IN std_logic_vector(2 DOWNTO 0);
        ctrl_out: OUT std_logic_vector(3 DOWNTO 0)
    );
END aluControl;

ARCHITECTURE RTL OF aluControl IS
    CONSTANT ALU_ADD:  std_logic_vector(3 DOWNTO 0) := "0000";
    CONSTANT ALU_SUB:  std_logic_vector(3 DOWNTO 0) := "0001";
    CONSTANT ALU_AND:  std_logic_vector(3 DOWNTO 0) := "0010";
    CONSTANT ALU_OR:   std_logic_vector(3 DOWNTO 0) := "0011";
    CONSTANT ALU_XOR:  std_logic_vector(3 DOWNTO 0) := "0100";

BEGIN
    ALUCtlLogic: PROCESS(ALUOp, funct7, funct3)
    BEGIN
    ctrl_out <= ALU_ADD; 
        CASE (ALUOp) IS
            WHEN "00" => 
                ctrl_out <= ALU_ADD;
            WHEN "01" => 
                ctrl_out <= ALU_SUB;
            WHEN "10" => 
                CASE funct3 IS
                    WHEN "000" =>
                        IF funct7(5) = '1' THEN 
                            ctrl_out <= ALU_SUB;
                        ELSE
                            ctrl_out <= ALU_ADD;
                        END IF;
                    WHEN "110" => 
                        ctrl_out <= ALU_OR;
                    WHEN "111" =>
                        ctrl_out <= ALU_AND;
                    WHEN OTHERS =>
                        ctrl_out <= (OTHERS => 'X');
                END CASE;
                WHEN "11" => 
                    CASE funct3 IS
                        WHEN "000" => -- ADDI
                            ctrl_out <= ALU_ADD;
                        WHEN OTHERS =>
                            ctrl_out <= (OTHERS => 'X');
                    END CASE;
                WHEN OTHERS =>
                    ctrl_out <= (OTHERS => 'X'); 
            END CASE;
    END PROCESS;
END RTL;
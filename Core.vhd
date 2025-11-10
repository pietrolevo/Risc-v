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
        reset: IN std_logic;
        ALU_Result: OUT std_logic_vector(31 DOWNTO 0);
        Zero_Flag: OUT std_logic
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
    
    COMPONENT ImmGen IS
        PORT(
            instruction: IN std_logic_vector(31 DOWNTO 0);
            sel: IN std_logic_vector(1 DOWNTO 0);
            result:      OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT add IS
        PORT(
            A: IN std_logic_vector(31 DOWNTO 0);
            B: IN std_Logic_vector(31 DOWNTO 0);
            y: OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT myMux IS
        PORT(
            A: IN std_logic_vector(31 DOWNTO 0);
            B: IN std_logic_vector(31 DOWNTO 0);
            sel: IN std_logic;
            y: OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT RegisterFile IS
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
    END COMPONENT;
    
    COMPONENT aluControl IS
        PORT(
            ALUOp: IN std_logic_vector(1 DOWNTO 0);
            funct7: IN std_logic_vector(6 DOWNTO 0);
            funct3: IN std_logic_vector(2 DOWNTO 0);
            ctrl_out: OUT std_logic_vector(3 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT ALU IS
    	PORT(
            op1: IN std_logic_vector(31 DOWNTO 0);
            op2: IN std_logic_vector(31 DOWNTO 0);
            ctrl: IN std_logic_vector(3 DOWNTO 0);
            res: OUT std_logic_vector(31 DOWNTO 0);
            zero: OUT std_logic
        );
    END COMPONENT;
    
    COMPONENT DataMem IS
        PORT(
            clk: IN std_Logic;
            MemWrite: IN std_logic;
            MemRead: IN std_logic;
            address: IN std_Logic_vector(31 DOWNTO 0);
            WriteData: IN std_logic_vector(31 DOWNTO 0);
            ReadData: OUT std_Logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT ControlUnit IS
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
    END COMPONENT;
    
    COMPONENT myAnd IS
        PORT(
            A, B: IN std_logic;
            y: OUT std_logic
        );
    END COMPONENT;
    
    SIGNAL new_pc: std_logic_vector(31 DOWNTO 0);
    SIGNAL pc_out_s: std_logic_vector(31 DOWNTO 0);
    SIGNAL instr: std_logic_vector(31 DOWNTO 0);
    SIGNAL imm_s: std_logic_vector(31 DOWNTO 0);
    SIGNAL pcPlusImm: std_logic_vector(31 DOWNTO 0);
    SIGNAL pc_in_s: std_logic_vector(31 DOWNTO 0);
    SIGNAL b, mr, mtr, mw, alsr, rw: std_logic;
    SIGNAL alop: std_logic_vector(1 DOWNTO 0);
    SIGNAL rd1, rd2: std_logic_vector(31 DOWNTO 0);
    SIGNAL op2: std_logic_vector(31 DOWNTO 0);
    SIGNAL alures: std_logic_vector(31 DOWNTO 0);
    SIGNAL aluctrl_s: std_logic_vector(3 DOWNTO 0);
    SIGNAL zero_s: std_logic;
    SIGNAL and_res: std_logic;
    SIGNAL dmout_s: std_logic_vector(31 DOWNTO 0);
    SIGNAL mx3: std_logic_vector(31 DOWNTO 0);
    SIGNAL immsel: std_logic_vector(1 DOWNTO 0);
    
BEGIN
    progcnt: ProgramCounter 
        PORT MAP(clk => clk, reset => reset, PC_in => pc_in_s, PC_out => pc_out_s);

    incr: PC_add
        PORT MAP(PC_addr => pc_out_s, res => new_pc);
        
    inmem: InstructionMem
        PORT MAP(ReadAddress => pc_out_s, Instruction => instr);
        
    immediategen: ImmGen
        PORT MAP(instruction => instr, sel => immsel, result => imm_s);
        
    pcimm: add
        PORT MAP(A => pc_out_s, B => imm_s, y => pcPlusImm);
      
    mux1: myMux
        PORT MAP(A => new_pc, B => pcPlusImm, sel => and_res, y => pc_in_s);
        
    rfile: RegisterFile
        PORT MAP(clk => clk, RegWrite => rw, ReadReg1 => instr(19 DOWNTO 15),
            ReadReg2 => instr(24 DOWNTO 20), WriteReg => instr(11 DOWNTO 7),
            WriteData => mx3, ReadData1 => rd1, ReadData2 => rd2);
            
    mux2: myMux
        PORT MAP(A => rd2, B => imm_s, sel => alsr, y => op2);
        
    aluctrl: aluControl
        PORT MAP(ALUOp => alop, funct7 => instr(31 DOWNTO 25), funct3 => instr(14 DOWNTO 12), 
        ctrl_out => aluctrl_s);
        
    mainalu: ALU
        PORT MAP(op1 => rd1, op2 => op2, ctrl =>  aluctrl_s, res => alures, zero => zero_s);
      
    andgate: myAnd
        PORT MAP(A => b, B => zero_s, y => and_res);
        
    dme: DataMem
        PORT MAP(clk => clk, MemWrite => mw, MemRead => mr, address => alures,
        WriteData => rd2, ReadData => dmout_s);
        
    mux3: myMux
       PORT MAP(A => alures, B => dmout_s, sel => mtr, y => mx3);   
       
    ctrl: ControlUnit
        PORT MAP(
            opcode => instr(6 DOWNTO 0),
            Branch => b,
            MemRead => mr,
            MemToReg => mtr,
            ALUOp => alop,
            MemWrite => mw,
            ALUSrc => alsr,
            RegWrite => rw,
            immsel => immsel
        );
    ALU_Result <= alures;
    Zero_Flag <= zero_s;
END Struct;
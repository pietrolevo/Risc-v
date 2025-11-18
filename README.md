# Building a RISC-V Processor from Datapath

## Note
This simple project it is not complete and need fixes, I did this just for learning better what i'm reading on the book.
I also tried to modify some parts compared to what was written in the book

## Useful References
- Page 113: Register Convention
- Page 126: Instruction Encoding
- Page 127: Instruction Format
- Page 173: RISC-V Instructions

---

## CORE (Page 268)

### Section 1: Fetching Instructions and Incrementing Program Counter (Page 262)
- **Instruction Memory**: Stores instructions of a program and supplies instructions given an address.
- **Program Counter (PC)**: Register that holds the address of the current instruction.
- **Adder**: Increments the PC to the address of the next instruction. (Ref: A-36)

### Section 2: R-Format Instructions (Page 263)
- **Register File**: Contains all registers; has two read ports and one write port. (Ref: A-56)
- **ALU**: Performs operations (+, -, AND, OR); includes control signals and zero detection output. (Ref: A-36)

### Section 3: Branches (Page 265)
- **Data Memory**: Supports read and write operations for store instructions; controlled via signals.
- **Immediate Generation Unit**: Extracts a 12-bit field from a 32-bit instruction (for load/store/branch) and sign-extends it to 32 bits.

### Section 4: Multiplexers (MUX)
- **MUX 1**: Supports a single register file and ALU.
- **MUX 2**: Supports a single register file and ALU.
- **MUX 3**: Selects between the next sequential instruction or a branch target.

---

## CONTROL UNIT (Page 277)

### Section 1: ALU Control (Page 270)
- **ALUOp**: Inputs are `funct7`, `funct3`, and a 2-bit control field; output is a 4-bit control signal for the ALU.

#### 🧾 R-Type Instruction Format (32-bit)
| Field     | Bits   | Description                              |
|-----------|--------|------------------------------------------|
| `opcode`  | 6:0    | Denotes operation and instruction format |
| `rd`      | 11:7   | Destination register                     |
| `funct3`  | 14:12  | Distinguishes operation                  |
| `rs1`     | 19:15  | First register operand                   |
| `rs2`     | 24:20  | Second register operand                  |
| `funct7`  | 31:25  | Further distinguishes operation          |

### Section 2: Main Control Unit (Appendix C)
| Signal     | Description |
|------------|-------------|
| `RegWrite` | Enables writing to the register specified in `rd` |
| `ALUSrc`   | Selects second ALU operand: register or immediate |
| `PCSrc`    | Chooses next PC: sequential (`PC+4`) or branch target |
| `MemRead`  | Enables reading from data memory |
| `MemWrite` | Enables writing to data memory |
| `MemToReg` | Selects data source for register write: ALU or memory |

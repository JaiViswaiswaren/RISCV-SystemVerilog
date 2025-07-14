# RISCV Single Cycle Processor Implementation in System Verilog

##  Project Goal

To implement a minimal RV32I single-cycle processor that supports:

* **ALU Operations**: `ADD`, `SUB`, `AND`, `OR`, `XOR`
* **Immediate Operations**: `ADDI`, `ANDI`, `ORI`, `XORI`
* **Load/Store**: `LW`, `SW`
* **Branching**: `BEQ`, `J` (unconditional jump)

The processor uses:

* 32 × 32-bit general-purpose registers
* Instruction memory and data memory
* A centralized control unit
* Fully synchronous PC updates

---

##  Supported ISA and Instruction Formats

The implementation covers all major instruction types in RV32I:

### R-Type
<img width="642" height="249" alt="Screenshot 2025-07-10 at 3 41 07 PM" src="https://github.com/user-attachments/assets/78cffc17-d458-4d22-b9bc-ba2761fe7fd2" />

### I-Type
<img width="651" height="254" alt="Screenshot 2025-07-10 at 3 53 06 PM" src="https://github.com/user-attachments/assets/67190674-9eee-4643-8eee-d23dc98f67ee" />

### S-Type
<img width="683" height="110" alt="Screenshot 2025-07-10 at 3 56 54 PM" src="https://github.com/user-attachments/assets/2b568169-9bb7-41ff-a65c-cea9c082dc56" />

### B-Type
<img width="772" height="101" alt="Screenshot 2025-07-10 at 3 43 00 PM" src="https://github.com/user-attachments/assets/e6556205-2066-4074-86b9-aada5ca3c064" />

### J-Type
<img width="706" height="102" alt="Screenshot 2025-07-10 at 3 43 22 PM" src="https://github.com/user-attachments/assets/4110b923-705d-4284-b9a4-e92e8c64c97a" />

##  Modules and Their Roles


| Module                  | Description                                                    |
| ----------------------- | -------------------------------------------------------------- |
| `PC.sv`                 | Program counter with branching support                         |
| `Instruction_Memory.sv` | Supplies instructions using current PC                         |
| `Register_File.sv`      | 32 x 32-bit register file, supports dual-read and single-write |
| `Imm_Block.sv`          | Immediate generator for I, S, B, J types                       |
| `Control_Unit.sv`       | Generates control signals based on opcode                      |
| `ALU_Control.sv`        | Decodes `funct3`, `funct7`, and `ALUOp` to generate `alu_ctrl` |
| `ALU.sv`                | Executes arithmetic and logical operations                     |
| `Data_Memory.sv`        | Byte-addressable memory for `lw` and `sw` operations           |
<img width="771" height="446" alt="image" src="https://github.com/user-attachments/assets/ea851a86-9e9b-4804-9483-dfaf6104587a" />


---
## ALU Control and Opcode details
<img width="216" height="497" alt="Screenshot 2025-07-11 at 3 32 54 PM" src="https://github.com/user-attachments/assets/635709dc-7f09-4756-be18-94e68828c216" />
<img width="300" height="212" alt="Screenshot 2025-07-10 at 6 40 36 PM" src="https://github.com/user-attachments/assets/1e4ab960-18f9-4399-81d0-2f6cb5773a0b" />

---
## Sample Instruction Trace
<img width="312" height="203" alt="Screenshot 2025-07-11 at 7 46 01 PM" src="https://github.com/user-attachments/assets/3844b66b-973d-4157-92e1-6db8acdd6224" />
<img width="815" height="365" alt="Screenshot 2025-07-12 at 3 18 44 PM" src="https://github.com/user-attachments/assets/989e7e08-e729-42d5-b406-2e84b79f9817" />
<img width="413" height="371" alt="Screenshot 2025-07-12 at 3 22 01 PM" src="https://github.com/user-attachments/assets/b1e69fb2-ff1a-4e4e-8083-7b73e31792b3" />

---
##  Final Result
<img width="993" height="377" alt="Screenshot 2025-07-14 at 6 14 17 PM" src="https://github.com/user-attachments/assets/a7da5cea-f6de-4da2-8ce4-384736fca078" />

---
##  Features

* Fully synthesizable RTL
* Modular and testbench-driven
* Handles edge cases like BEQ with false condition and skipped instructions via JAL
* Byte-addressable memory for load/store

---
## Credits
* Avyakth Devarajan for helping me debugging the code.
* Official documentation of RISC V.
* Chatgpt for README and some help in the testbench code.

## 📃 License

This project is open source and free to use for learning and research.

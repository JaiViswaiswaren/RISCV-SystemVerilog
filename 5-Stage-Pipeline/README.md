# RV32I 5-Stage Pipelined Processor (SystemVerilog)

Implements a 5-stage pipelined RV32I processor in SystemVerilog with hazard detection, stalling, and forwarding support.

---

## 🔧 Architecture

<img width="2299" height="998" alt="image" src="https://github.com/user-attachments/assets/beb87d1f-f2ae-47ed-94a7-439a39fa1b54" />

---

##  Module Descriptions

| Module              | Description |
|---------------------|-------------|
| `PC_Module.sv`      | Program Counter with PC + 4/BEQ/J logic |
| `Instruction_Memory.sv` | Fetches instruction in IF stage |
| `IF_ID_REG.sv`      | IF to ID pipeline register |
| `ID_EX_REG.sv`      | ID to EX pipeline register |
| `EX_M_REG.sv`       | EX to MEM pipeline register |
| `M_WB_REG.sv`       | MEM to WB pipeline register |
| `Register_File.sv`  | General-purpose registers |
| `Imm_Block.sv`      | Immediate generator |
| `Control_Unit.sv`   | Generates main control signals |
| `ALU_Unit.sv`       | Performs ALU operations |
| `ALU_Control.sv`    | ALU control signal logic |
| `Data_Memory.sv`    | Handles load/store memory access |
| `Forward_Unit.sv`   | Detects and resolves RAW hazards via forwarding |
| `LW_Stall_Unit.sv`  | Detects and stalls on load-use hazard |
| `BEQ_J_Unit.sv`     | Branch and jump control logic |
| `WB_Mux.sv`         | Selects write-back data from MEM/ALU |
| `RISCV_pkg.sv`      | Shared enums, ALU ops, opcode values |
| `top_module.sv`     | Final integration of the full datapath |

---

## ⏱️ Pipeline Timing

| Cycle →    | 1  | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 10 | 11 | 12 | 13 | 14 |
|------------|----|----|----|----|----|----|----|----|----|----|----|----|----|----|
| PC = 0     | IF | ID | EX | M  | WB |    |    |    |    |    |    |    |    |    |
| PC = 4     |    | IF | ID | EX | M  | WB |    |    |    |    |    |    |    |    |
| PC = 8     |    |    | IF | ID | EX |    |    |    |    |    |    |    |    |    |
| PC = 12    |    |    |    | IF | ID | EX |    |    |    |    |    |    |    |    |
| PC = 16    |    |    |    |    | IF | ID |    |    |    |    |    |    |    |    |
| PC = 20    |    |    |    |    |    |    | IF | ID | EX | M  | WB |    |    |    |
| PC = 24    |    |    |    |    |    |    |    | IF | ID | EX | M  | WB |    |    |
| PC = 28    |    |    |    |    |    |    |    |    | IF | IF | ID | EX | M  | WB |


---


##  Features

- 5 pipeline stages: IF, ID, EX, MEM, WB  
- Hazard detection and stalling logic  
- Forwarding Unit to prevent unnecessary stalls  
- Testbench driven verification

---
##  Testing

Simulated using a sample instruction trace:
- Arithmetic, branching, memory access, and jumps
- Initial values: `x5 = 5`, rest zeroed
- Memory initialized to zero

<img width="1244" height="796" alt="image" src="https://github.com/user-attachments/assets/b2ec38a6-dc33-412d-a447-f5479dd2c7af" />

---

## 👤 Credits

- Avyakth Devarajan – Debugging
- RISC-V documentation  
- ChatGPT – README and support logic help

---

## 🪪 License

This processor design is open-source and free to use in academic and research settings.


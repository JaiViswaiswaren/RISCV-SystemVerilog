# RV32I Single-Cycle Processor (SystemVerilog)

This is a minimal RV32I single-cycle processor implemented in SystemVerilog. Every instruction executes in a single clock cycle.

---

##  Architecture

<img width="1600" height="955" alt="image" src="https://github.com/user-attachments/assets/0df4985b-35c0-427a-853e-31a0507927f1" />

---

##  Module Descriptions

| Module                | Description |
|-----------------------|-------------|
| `PC_Module.sv`        | Updates Program Counter (PC ← PC + 4) |
| `Instruction_Memory.sv` | ROM that holds instructions |
| `Register_File.sv`    | 32 × 32-bit register file |
| `ALU_Unit.sv`         | Executes arithmetic/logic operations |
| `ALU_Control.sv`      | Generates ALU control signals from `funct3`, `funct7` |
| `Control_Unit.sv`     | Decodes the opcode and generates control signals |
| `Imm_Block.sv`        | Immediate generator with sign-extension |
| `Data_Memory.sv`      | Load (`lw`) and Store (`sw`) memory |
| `RISCV_pkg.sv`        | Common definitions: opcodes, ALU ops, enums |
| `design.sv`           | Top-level file integrating all modules |

---


##  Testing

Simulated using a sample instruction trace:
- Arithmetic, branching, memory access, and jumps
- Initial values: `x5 = 5`, rest zeroed
- Memory initialized to zero
<img width="993" height="377" alt="Screenshot 2025-07-14 at 6 14 17 PM" src="https://github.com/user-attachments/assets/a7da5cea-f6de-4da2-8ce4-384736fca078" />

---

##  Credits

- Avyakth Devarajan – Debugging
- RISC-V ISA documentation
- ChatGPT – README and testbench assistance

---

##  License

This project is open-source and intended for educational use.

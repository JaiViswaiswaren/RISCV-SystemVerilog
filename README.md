# RISCV Processor Implementation in System Verilog

## Project Goal

To implement a minimal RV32I:

[Single-Cycle Processor](https://github.com/JaiViswaiswaren/RISCV-SystemVerilog/tree/main/Single-Cycle)  
[5-Stage Pipelined Processor](https://github.com/JaiViswaiswaren/RISCV-SystemVerilog/tree/main/5-Stage-Pipeline)

This processor supports:

* **ALU Operations**: `ADD`, `SUB`, `AND`, `OR`, `XOR`
* **Immediate Operations**: `ADDI`, `ANDI`, `ORI`, `XORI`
* **Load/Store**: `LW`, `SW`
* **Branching**: `BEQ`, `J` (unconditional jump)

The processor uses:

* 32 × 32-bit general-purpose registers  
* Instruction memory and data memory

---

## Supported ISA and Instruction Formats

### R-Type

| Instruction | funct7 [31:25] | rs2 [24:20] | rs1 [19:15] | funct3 [14:12] | rd [11:7] | opcode [6:0] | Type |
|-------------|----------------|-------------|-------------|----------------|-----------|---------------|------|
| add         | 0000000         | xxxxx       | xxxxx       | 000            | xxxxx     | 0110011        | R    |
| sub         | 0100000         | xxxxx       | xxxxx       | 000            | xxxxx     | 0110011        | R    |
| and         | 0000000         | xxxxx       | xxxxx       | 111            | xxxxx     | 0110011        | R    |
| or          | 0000000         | xxxxx       | xxxxx       | 110            | xxxxx     | 0110011        | R    |
| xor         | 0000000         | xxxxx       | xxxxx       | 100            | xxxxx     | 0110011        | R    |

### I-Type

| Instruction | imm[11:0] [31:20] | rs1 [19:15] | funct3 [14:12] | rd [11:7] | opcode [6:0] | Type |
|-------------|-------------------|-------------|----------------|-----------|---------------|------|
| addi        | iiiiiiiiiiii       | xxxxx       | 000            | xxxxx     | 0010011        | I    |
| andi        | iiiiiiiiiiii       | xxxxx       | 111            | xxxxx     | 0010011        | I    |
| ori         | iiiiiiiiiiii       | xxxxx       | 110            | xxxxx     | 0010011        | I    |
| xori        | iiiiiiiiiiii       | xxxxx       | 100            | xxxxx     | 0010011        | I    |
| lw          | iiiiiiiiiiii       | xxxxx       | 010            | xxxxx     | 0000011        | I    |

### S-Type

| Instruction | imm[11:5] [31:25] | rs2 [24:20] | rs1 [19:15] | funct3 [14:12] | imm[4:0] [11:7] | opcode [6:0] | Type |
|-------------|-------------------|-------------|-------------|----------------|------------------|---------------|------|
| sw          | iiiiiii            | xxxxx       | xxxxx       | 010            | iiiii            | 0100011        | S    |

### B-Type

| Instruction | imm[12] [31] | imm[10:5] [30:25] | rs2 [24:20] | rs1 [19:15] | funct3 [14:12] | imm[4:1] [11:8] | imm[11] [7] | opcode [6:0] | Type |
|-------------|--------------|-------------------|-------------|-------------|----------------|------------------|--------------|---------------|------|
| beq         | i            | iiiiii             | xxxxx       | xxxxx       | 000            | iiii             | i            | 1100011        | B    |

### J-Type

| Instruction | imm[20] [31] | imm[10:1] [30:21] | imm[11] [20] | imm[19:12] [19:12] | rd [11:7] | opcode [6:0] | Type |
|-------------|---------------|-------------------|---------------|----------------------|-----------|---------------|------|
| jal         | i             | iiiiiiiiii         | i             | iiiiiiii             | xxxxx     | 1101111        | J    |

---

## Sample Instruction Trace

### Register Initial Values

| Register | Value |
|----------|--------|
| x0       | 0      |
| x5       | 5      |
| Others   | 0      |

Memory `mem[0 to 31] = 0`

### Execution Table

| Address | Instruction     | Operation                      | Result / Effect                       | 32-bit Binary Instruction                     |
|---------|------------------|--------------------------------|----------------------------------------|------------------------------------------------|
| 0       | addi x1,x0,-3    | x1 = x0 + (-3)                 | x1 = -3                                | `0xFFD00893`                                   |
| 4       | xor x4,x5,x1     | x4 = x5 ^ x1                   | x4 = 5 ^ -3 = -8                        | `0x012C233`                                    |
| 8       | beq x1,x4,+8     | x1 != x4 → no branch           | skip next                              | `0x0120463`                                    |
| 12      | jal x0,+8        | Jump +8                        | x0 = don't care, Jump to PC+8          | `0x0080006F`                                   |
| 16      | addi x9,x9,100   | Skipped                        | No effect                              | `0x06448493`                                   |
| 20      | sw x5,0(x0)      | mem[0] = x5                    | mem[0–3] = 0x05 (little-endian)        | `0x00502023`                                   |
| 24      | lw x6,0(x0)      | x6 = mem[0]                    | x6 = 5                                 | `0x00002303`                                   |
| 28      | add x7,x6,x1     | x7 = x6 + x1 = 5 + (-3) = 2    | x7 = 2                                 | `0x01303B3`                                    |

---

## Final State

| Register | Value      |
|----------|------------|
| x1       | -3         |
| x4       | -8         |
| x5       | 5          |
| x6       | 5          |
| x7       | 2          |
| x9       | 0 (skipped) |

### Memory:
mem[0] to mem[3] = 0x00000005 (little endian)

---
## Credits
* Avyakth Devarajan for helping me debugging the code.
* Official documentation of RISC V.
* Chatgpt for README and some help in the testbench code.

##  License

This project is open source and free to use for learning and research.

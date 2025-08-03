# RISCV Processor Implementation in System Verilog

##  Project Goal

To implement a minimal RV32I :

[Single-Cycle Processor](https://github.com/JaiViswaiswaren/RISCV-SystemVerilog/tree/main/Single-Cycle) 

[5-Stage Pipelined Processor](https://github.com/JaiViswaiswaren/RISCV-SystemVerilog/tree/main/5-Stage-Pipeline) 

This processor that supports:

* **ALU Operations**: `ADD`, `SUB`, `AND`, `OR`, `XOR`
* **Immediate Operations**: `ADDI`, `ANDI`, `ORI`, `XORI`
* **Load/Store**: `LW`, `SW`
* **Branching**: `BEQ`, `J` (unconditional jump)

The processor uses:

* 32 × 32-bit general-purpose registers
* Instruction memory and data memory

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


---

## Sample Instruction Trace
<img width="312" height="203" alt="Screenshot 2025-07-11 at 7 46 01 PM" src="https://github.com/user-attachments/assets/3844b66b-973d-4157-92e1-6db8acdd6224" />
<img width="815" height="365" alt="Screenshot 2025-07-12 at 3 18 44 PM" src="https://github.com/user-attachments/assets/989e7e08-e729-42d5-b406-2e84b79f9817" />
<img width="413" height="371" alt="Screenshot 2025-07-12 at 3 22 01 PM" src="https://github.com/user-attachments/assets/b1e69fb2-ff1a-4e4e-8083-7b73e31792b3" />

---

## Credits
* Avyakth Devarajan for helping me debugging the code.
* Official documentation of RISC V.
* Chatgpt for README and some help in the testbench code.

##  License

This project is open source and free to use for learning and research.

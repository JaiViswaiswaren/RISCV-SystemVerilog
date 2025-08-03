`timescale 1ns/1ps

package RISCV_pkg;

typedef logic [31:0] word_t;  //for defining a 32 bit value

typedef logic [4:0] reg_t;  //for defining a 5 bit value


typedef enum logic [6:0] {
  R_Type = 7'b0110011,
  I_Type = 7'b0010011,
  LW     = 7'b0000011,
  SW     = 7'b0100011,
  BEQ_op    = 7'b1100011,
  J_op      = 7'b1101111
}opcode_t;

typedef enum logic [2:0] {
  AND = 3'b000,
  OR  = 3'b001,
  XOR = 3'b010,
  SUB = 3'b110,
  ADD = 3'b111
}alu_ctrl_t;



// pipeline registers
typedef struct packed {
  //as per inputs
  logic [31:0] instr;
  logic [31:0] pc;
} IF_ID_t;

typedef struct packed {
  logic [31:0] imm32;
  logic [31:0] rd1;
  logic [31:0] rd2;
  logic [4:0] rs1;
  logic [4:0] rs2;
  logic [4:0] rd;
  logic [31:0] pc;
  logic wr;      
  logic alu_src;
  logic beq;
  logic beq_j;
  logic d_rd;     
  logic d_wr;
  logic [2:0] alu_ctrl;
} ID_EX_t;

typedef struct packed {
  logic d_rd;     
  logic d_wr;
  logic wr;
  logic [31:0] alu_out;
  logic [31:0] wd;
  logic [4:0] rd;    
} EX_MEM_t; 

typedef struct packed {
  logic wr;
  logic drd;
  logic [31:0] alu_out;
  logic [31:0] data_out;
  logic [4:0] rd;
} MEM_WB_t; 

endpackage

`timescale 1ns/1ps

import RISCV_pkg::*;

module IF_ID_REG (
  input  logic clk,
  input  logic rst,
  input  logic reg_rst,
  input  logic [31:0] Instruction_1,
  input  logic [31:0] PC_Out_1,
  output logic [31:0] Instruction_2,
  output logic [4:0]  RS1_2,
  output logic [4:0]  RS2_2,
  output logic [4:0]  RD_2,
  output logic [31:0] PC_Out_2
);


  IF_ID_t ifid_reg;

  // Register the instruction and PC on clock edge
  always_ff @(posedge clk or posedge rst or posedge reg_rst) begin
    if (rst || reg_rst)
      ifid_reg <= 0;
    else begin
      ifid_reg.instr <= Instruction_1;
      ifid_reg.pc    <= PC_Out_1;
    end
  end

  // Output assignments
  assign Instruction_2 = ifid_reg.instr;
  assign PC_Out_2      = ifid_reg.pc;
  assign RS1_2         = ifid_reg.instr[19:15];
  assign RS2_2         = ifid_reg.instr[24:20];
  assign RD_2          = ifid_reg.instr[11:7];

endmodule


`timescale 1ns/1ps

import RISCV_pkg::*;

module ID_EX_REG (
  input  logic clk,
  input  logic rst,
  input  logic reg_rst,
  input word_t imm32_2,
  input word_t RD_1_2,RD_2_2,
  input logic [4:0] RS1_2,RS2_2,RD_2,
  input word_t PC_Out_2,
  input logic WR,      
  input logic ALU_Src,
  input logic BEQ,
  input logic BEQ_J,
  input logic D_RD,      
  input logic D_WR,
  input [2:0] alu_ctrl,

  output word_t imm32_3,
  output word_t RD_1_3,RD_2_3,
  output logic [4:0] RS1_3,RS2_3,RD_3,
  output word_t PC_Out_3,
  output logic WR_3,      
  output logic ALU_Src_3,
  output logic BEQ_3,
  output logic BEQ_J_3,
  output logic D_RD_3,      
  output logic D_WR_3,
  output [2:0] ALU_Ctrl_3
);


  ID_EX_t idex_reg;

  // Register the instruction and PC on clock edge
  always_ff @(posedge clk or posedge rst or posedge reg_rst) begin
    if (rst || reg_rst) begin
      idex_reg          <= 0;
    end else begin
      idex_reg.imm32       <= imm32_2;
      idex_reg.rd1         <= RD_1_2;
      idex_reg.rd2         <= RD_2_2;
      idex_reg.rs1         <= RS1_2;
      idex_reg.rs2         <= RS2_2;
      idex_reg.rd          <= RD_2;
      idex_reg.pc          <= PC_Out_2;
      idex_reg.wr          <= WR;
      idex_reg.alu_src     <= ALU_Src;
      idex_reg.beq         <= BEQ;
      idex_reg.beq_j       <= BEQ_J;
      idex_reg.d_rd        <= D_RD;
      idex_reg.d_wr        <= D_WR;
      idex_reg.alu_ctrl    <= alu_ctrl;
    end
  end

  // Output assignments
  assign  imm32_3     = idex_reg.imm32;
  assign  RD_1_3      = idex_reg.rd1;
  assign  RD_2_3      = idex_reg.rd2;
  assign  RS1_3       = idex_reg.rs1;
  assign  RS2_3       = idex_reg.rs2;
  assign  RD_3        = idex_reg.rd;
  assign  PC_Out_3    = idex_reg.pc;
  assign  WR_3        = idex_reg.wr;
  assign  ALU_Src_3   = idex_reg.alu_src;
  assign  BEQ_3       = idex_reg.beq;
  assign  BEQ_J_3     = idex_reg.beq_j;
  assign  D_RD_3      = idex_reg.d_rd;
  assign  D_WR_3      = idex_reg.d_wr;
  assign  ALU_Ctrl_3  = idex_reg.alu_ctrl;


endmodule


`timescale 1ns/1ps

import RISCV_pkg::*;

module EX_M_REG (
  input logic clk,
  input logic rst,
  input logic reg_rst,

  input logic D_RD_3,      
  input logic D_WR_3,
  input logic WR_3,
  input word_t ALU_Out_3,
  input word_t RD_2_3,
  input logic [4:0] RD_3,

  output logic D_RD_4,      
  output logic D_WR_4,
  output logic WR_4,
  output word_t ALU_Out_4,
  output word_t RD_2_4,
  output logic [4:0] RD_4
);
  EX_MEM_t exmem_reg;

  // Register the instruction and PC on clock edge
  always_ff @(posedge clk or posedge rst or posedge reg_rst) begin
    if (rst || reg_rst)
      exmem_reg <= 0;
    else begin
      exmem_reg.d_rd    <= D_RD_3;
      exmem_reg.d_wr    <= D_WR_3;
      exmem_reg.wr      <= WR_3;
      exmem_reg.alu_out <= ALU_Out_3;
      exmem_reg.wd      <= RD_2_3;
      exmem_reg.rd      <= RD_3;
    end
  end

  // Output assignments
  assign D_RD_4 = exmem_reg.d_rd;
  assign D_WR_4 = exmem_reg.d_wr;
  assign WR_4 = exmem_reg.wr;
  assign ALU_Out_4 = exmem_reg.alu_out;
  assign RD_2_4 = exmem_reg.wd;
  assign RD_4 = exmem_reg.rd; 

endmodule


`timescale 1ns/1ps

import RISCV_pkg::*;

module M_WB_REG (
  input logic clk,
  input logic rst,
  input logic reg_rst,
  input logic D_RD_4,
  input logic WR_4,
  input word_t ALU_Out_4,
  input word_t Data_Out_4,
  input logic [4:0] RD_4,
  output logic D_RD_5,

  output logic WR_5,
  output word_t ALU_Out_5,
  output word_t Data_Out_5,
  output logic [4:0] RD_5
);
  MEM_WB_t memwb_reg;

  // Register the instruction and PC on clock edge
  always_ff @(posedge clk or posedge rst or posedge reg_rst) begin
    if (rst || reg_rst)
      memwb_reg <= 0;
    else begin
      memwb_reg.wr      <= WR_4;
      memwb_reg.alu_out <= ALU_Out_4;
      memwb_reg.data_out<= Data_Out_4;
      memwb_reg.rd      <= RD_4;
      memwb_reg.drd     <= D_RD_4;
    end
  end

  // Output assignments

  assign WR_5 = memwb_reg.wr;
  assign ALU_Out_5 = memwb_reg.alu_out;
  assign Data_Out_5 = memwb_reg.data_out;
  assign RD_5 = memwb_reg.rd; 
  assign D_RD_5 =  memwb_reg.drd;
endmodule


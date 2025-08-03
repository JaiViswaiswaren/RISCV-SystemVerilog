`timescale 1ns/1ps

import RISCV_pkg::*;

module Imm_Block(
  input logic clk,                  //clock
  input logic rst,                  //reset
  input word_t Instruction_2,       
  output logic signed [31:0] imm32_2
);
  opcode_t opcode;

  always @(*) begin
    opcode = opcode_t'(Instruction_2[6:0]);//explicit cast


    //giving out signed immediate values to the respective instruction type
    case(opcode) 
      R_Type: imm32_2 = 0;
      I_Type: imm32_2 = $signed(Instruction_2[31:20]); 
      LW:     imm32_2 = $signed(Instruction_2[31:20]); 
      SW:     imm32_2 = $signed({Instruction_2[31:25], Instruction_2[11:7]}); 
      BEQ_op:    imm32_2 = $signed({Instruction_2[31], Instruction_2[7], Instruction_2[30:25], Instruction_2[11:8], 1'b0});
      J_op:      imm32_2 = $signed({Instruction_2[31], Instruction_2[19:12], Instruction_2[20], Instruction_2[30:21], 1'b0}); 
      default:imm32_2 = 0; 
    endcase
  end    
endmodule

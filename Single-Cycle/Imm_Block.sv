`timescale 1ns/1ps
 
import RISCV_pkg::*;

module Imm_Block(
  input logic clk,                //clock
  input logic rst,                //reset
  input word_t instruction,       //from instruction memory
  output logic signed [31:0] imm32//to alu, pc
);
  opcode_t opcode;

  always @(*) begin
  opcode = opcode_t'(instruction[6:0]);//explicit cast

  
//giving out signed immediate values to the respective instruction type
    case(opcode) 
      R_Type: imm32 = 0;
      I_Type: imm32 = $signed(instruction[31:20]); 
      LW:     imm32 = $signed(instruction[31:20]); 
      SW:     imm32 = $signed({instruction[31:25], instruction[11:7]}); 
      BEQ:    imm32 = $signed({instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0});
      J:      imm32 = $signed({instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0}); 
      default:imm32 = 0; 
  endcase
end    
endmodule
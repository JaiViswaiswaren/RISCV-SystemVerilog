`timescale 1ns/1ps
 
import RISCV_pkg::*;

module ALU(
  input alu_ctrl_t alu_ctrl,//from alu control
  input word_t rd1,         //from regfile
  input word_t rd2,         //from regfile
  input word_t imm32,       //from imm block
  input logic alu_src,      //from control unit
  output logic ALU_zero,    //to pc
  output word_t ALU_out32   //to data memory
);
word_t a, b;
assign a = rd1;
assign b = alu_src ? imm32 : rd2;
  always_comb begin
  
    case(alu_ctrl)
      ADD:ALU_out32 = a+b;
      SUB:ALU_out32 = b-a;
      AND:ALU_out32 = a&b;
      OR :ALU_out32 = a|b;
      XOR:ALU_out32 = a^b;
      default:ALU_out32 = 32'd0;
    endcase
	
    ALU_zero = (a == b) ? 1'b1: 1'b0 ;
  end
      
endmodule

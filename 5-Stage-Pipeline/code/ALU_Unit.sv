`timescale 1ns/1ps

import RISCV_pkg::*;

module ALU_Unit(
  input alu_ctrl_t ALU_ctrl_3,
  input word_t RD_1_3,         
  input word_t RD_2_3,         
  input word_t imm32_3,
  input word_t ALU_Out_4,
  input word_t Write_Data,
  input logic [1:0] Sel_A,Sel_B,      
  output logic zero,    
  output word_t ALU_out_3   
);
  word_t a, b;
  always_comb begin
    case(Sel_A)
      2'b00: a = RD_1_3;
      2'b01: a = ALU_Out_4;
      2'b10: a = Write_Data;
      default: a = RD_1_3;
    endcase  

    case(Sel_B)
      2'b00: b = RD_2_3;
      2'b01: b = ALU_Out_4;
      2'b10: b = Write_Data;
      2'b11: b = imm32_3;
      default: b = RD_2_3;
    endcase
  end

  always_comb begin

    case(ALU_ctrl_3)
      ADD:ALU_out_3 = a+b;
      SUB:ALU_out_3 = b-a;
      AND:ALU_out_3 = a&b;
      OR :ALU_out_3 = a|b;
      XOR:ALU_out_3 = a^b;
      default:ALU_out_3 = 32'd0;
    endcase

    if(ALU_ctrl_3 == SUB) begin
      zero = (a == b) ? 1'b1: 1'b0 ;
    end else begin
      zero = 1'b0;
    end
  end

endmodule

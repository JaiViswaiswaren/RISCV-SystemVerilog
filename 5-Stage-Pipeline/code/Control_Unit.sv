`timescale 1ns/1ps

import RISCV_pkg::*;

module Control_Unit(
  input logic clk,          
  input logic rst,          
  input word_t Instruction_2, 
  output logic [1:0] alu_op,
  output logic WR,      
  output logic ALU_Src,
  output logic BEQ,
  output logic BEQ_J,
  output logic D_RD,      
  output logic D_WR       
);
  opcode_t opcode;

  always @(*) begin
    opcode = opcode_t'(Instruction_2[6:0]);//explicit cast


    case(opcode) 
      R_Type:begin
        alu_op = 2'b10;
        WR = 1'b1;
        ALU_Src = 1'b0;//rd2
        BEQ = 1'b0;
        BEQ_J = 1'b0;
        D_RD = 1'b0;
        D_WR = 1'b0;
      end
      I_Type:begin
        alu_op = 2'b11;
        WR = 1'b1;
        ALU_Src = 1'b1;//imm
        BEQ = 1'b0;
        BEQ_J = 1'b0;
        D_RD = 1'b0;
        D_WR = 1'b0;               
      end
      LW:begin
        alu_op = 2'b00;
        WR = 1'b1;
        ALU_Src = 1'b1;
        BEQ = 1'b0;
        BEQ_J = 1'b0;
        D_RD = 1'b1;
        D_WR = 1'b0;                
      end
      SW:begin
        alu_op = 2'b00;
        WR = 1'b0;
        ALU_Src = 1'b1;
        BEQ = 1'b0;
        BEQ_J = 1'b0;
        D_RD = 1'b0;
        D_WR = 1'b1;                
      end
      BEQ_op:begin
        alu_op = 2'b01;
        WR = 1'b0;
        ALU_Src = 1'b0;
        BEQ = 1'b1;
        BEQ_J = 1'b1;
        D_RD = 1'b0;
        D_WR = 1'b0;               
      end
      J_op:begin
        alu_op = 2'b00;
        WR = 1'b0;
        ALU_Src = 1'b0;
        BEQ = 1'b0;
        BEQ_J = 1'b1;
        D_RD = 1'b0;
        D_WR = 1'b0;               
      end
      default:begin
        // Default values
        alu_op = 2'b00;
        WR = 1'b0;
        ALU_Src = 1'b0;
        BEQ = 1'b0;
        BEQ_J = 1'b0;
        D_RD = 1'b0;
        D_WR = 1'b0;  		  
      end
    endcase
  end   

endmodule

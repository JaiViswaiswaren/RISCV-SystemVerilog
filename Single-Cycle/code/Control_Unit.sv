`timescale 1ns/1ps
 
import RISCV_pkg::*;

module Control_Unit(
  input logic clk,          //clock
  input logic rst,          //reset
  input word_t instruction, //from instruction memory
  output logic [1:0] alu_op,//to alu control
  output pc_src_t pc_src,   //to pc
  output logic reg_wr,      //to reg file
  output logic alu_src,     //to the mux in alu block
  output logic mem_reg,     //to the select line in the mux in data memory
  output logic mem_wr,      //to data memory
  output logic mem_rd       //to data memory
);
  opcode_t opcode;

always @(*) begin
  opcode = opcode_t'(instruction[6:0]);//explicit cast


    case(opcode) 
      R_Type:begin
        alu_op  = 2'b10;
        pc_src  = PC_4;
        reg_wr  = 1'b1;
        alu_src = 1'b0;
        mem_reg = 1'b0;
        mem_wr  = 1'b0;
        mem_rd  = 1'b0;
      end
      I_Type:begin
        alu_op  = 2'b11;
        pc_src  = PC_4;
        reg_wr  = 1'b1;
        alu_src = 1'b1;
        mem_reg = 1'b0;
        mem_wr  = 1'b0;
        mem_rd  = 1'b0;        
      end
      LW:begin
        alu_op  = 2'b00;
        pc_src  = PC_4;
        reg_wr  = 1'b1;
        alu_src = 1'b1;
        mem_reg = 1'b1;
        mem_wr  = 1'b0;
        mem_rd  = 1'b1;        
      end
      SW:begin
        alu_op  = 2'b00;
        pc_src  = PC_4;
        reg_wr  = 1'b0;
        alu_src = 1'b1;
        mem_wr  = 1'b1;
        mem_rd  = 1'b0;        
      end
      BEQ:begin
        alu_op  = 2'b01;
        pc_src  = PC_B;
        reg_wr  = 1'b0;
        alu_src = 1'b0;
        mem_wr  = 1'b0;
        mem_rd  = 1'b0;        
      end
      J:begin
        alu_op  = 2'b00;
        pc_src  = PC_J;
        reg_wr  = 1'b0;
        mem_wr  = 1'b0;
        mem_rd  = 1'b0;        
      end
      default:begin
          // Default values
  		  alu_op  = 2'b00;
  		  pc_src  = PC_4;
          reg_wr  = 1'b0;
          alu_src = 1'b0;
          mem_reg = 1'b0;
          mem_wr  = 1'b0;
          mem_rd  = 1'b0;
      end
  endcase
end   
  
endmodule

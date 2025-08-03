`timescale 1ns/1ps
 
import RISCV_pkg::*;

module PC(
  input logic clk,      //clock
  input logic rst,      //reset
  input word_t imm32,   //from Imm_Block
  input pc_src_t pc_src,//from Control_Unit
  input logic ALU_zero, //from ALU
  output word_t pc_out  //to Instruction_Memory
);

  word_t reg_pc=0;// set at initial
  assign pc_out = reg_pc;

  always_ff @(posedge clk or posedge rst) begin
    
    if(rst) begin
      reg_pc <= 0;
    
    end else begin
      case(pc_src)
        
        //for r-type,i-type,s-type 
        PC_4:begin
          reg_pc <= reg_pc + 4;
        end
        
        //for branch
        PC_B:begin                   
          if(ALU_zero) begin
            reg_pc <= reg_pc + imm32;
          end else begin
            reg_pc <= reg_pc + 4;
          end
        end
        
        //for jump
        PC_J:begin
          reg_pc <= reg_pc + imm32;
        end
        
        //default case
        default: begin
          reg_pc <= reg_pc + 4;      
        end
        
      endcase
    end
  end

endmodule

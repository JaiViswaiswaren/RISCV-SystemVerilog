`timescale 1ns/1ps
 
import RISCV_pkg::*;

module ALU_Control(
  input logic clk,          //clock
  input logic rst,          //reset
  input word_t instruction, //from instruction memory
  input logic [1:0] alu_op, //from control unit
  output alu_ctrl_t alu_ctrl//to alu
);
  logic [2:0] funct3;
  
  logic [6:0] funct7;
  opcode_t opcode;

always @(*) begin
  funct3 = instruction[14:12];
  funct7 = instruction[31:25];
  opcode = opcode_t'(instruction[6:0]);//explicit cast
  case(opcode) 
      R_Type:begin
        case(funct3)
          3'b000:begin
            if(funct7 == 7'b0000000) begin
            	alu_ctrl = ADD;
            end else if (funct7 == 7'b0100000) begin
                alu_ctrl = SUB;
            end else begin
              alu_ctrl = ADD; // fallback
            end
          end
          3'b111:alu_ctrl = AND;  
          3'b110:alu_ctrl = OR;
          3'b100:alu_ctrl = XOR;
          default:alu_ctrl = ADD;
        endcase  
      end
      I_Type:begin
        case(funct3)
          3'b000:alu_ctrl = ADD;
          3'b111:alu_ctrl = AND;  
          3'b110:alu_ctrl = OR;
          3'b100:alu_ctrl = XOR;
          default:alu_ctrl = ADD;         
        endcase  
      end 
      LW:alu_ctrl = ADD;     
      SW:alu_ctrl = ADD;
      BEQ:alu_ctrl = SUB;
      default:alu_ctrl = ADD;
  endcase
end
endmodule
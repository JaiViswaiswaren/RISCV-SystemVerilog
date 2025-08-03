`timescale 1ns/1ps

import RISCV_pkg::*;

module BEQ_J_Unit(
  input logic clk,
  input logic rst,
  input word_t imm32_3,
  input word_t PC_Out_3,
  input logic BEQ_3,
  input logic BEQ_J_3,
  input logic zero,
  output logic reg_rst,
  output logic PC_Src,
  output word_t PC_B_J
);
  //  word_t PC_B,PC_J; 

  assign PC_B_J = PC_Out_3 + imm32_3;
  /*
  assign PC_B = PC_Out_3 + imm32_3;
  assign PC_J = PC_Out_3 + imm32_3;  
  always_comb begin
    if(BEQ_3)
      PC_B_J = PC_B;
    else
      PC_B_J = PC_J;
  end  
*/
  always_comb begin
    if(BEQ_3 && BEQ_J_3 && zero)//if branch and cond satisfy
      PC_Src = 1'b1;
    else if (~BEQ_3 && BEQ_J_3)//if jump
      PC_Src = 1'b1;
    else
      PC_Src = 1'b0;    
  end
  //for initialising
  always_ff @ (posedge rst) begin
    if (rst)
      PC_Src <= 0;  
  end
  //if branch or jump taken, flush all reg
  assign reg_rst = PC_Src;

endmodule

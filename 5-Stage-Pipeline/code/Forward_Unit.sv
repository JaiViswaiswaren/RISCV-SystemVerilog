`timescale 1ns/1ps

import RISCV_pkg::*;

module Forward_Unit(
  input logic ALU_Src_3,
  input logic [4:0] RS1_3,
  input logic [4:0] RS2_3,
  input logic [4:0] RD_4,
  input logic [4:0] RD_5,
  output logic [1:0] Sel_A,
  output logic [1:0] Sel_B  
);

  always_comb begin
    if (RS1_3 == RD_4 && RD_4 != 5'd0)
      Sel_A = 2'b01;
    else if (RS1_3 == RD_5 && RD_5 != 5'd0)
      Sel_A = 2'b10;
    else 
      Sel_A = 2'b00;
  end

  always_comb begin
    if (RS2_3 == RD_4 && RD_4 != 5'd0)
      Sel_B = 2'b01;
    else if (RS2_3 == RD_5 && RD_5 != 5'd0)
      Sel_B = 2'b10;
    else if (ALU_Src_3)
      Sel_B = 2'b11;
    else 
      Sel_B = 2'b00;
  end

endmodule

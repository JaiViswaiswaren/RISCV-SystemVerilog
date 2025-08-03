`timescale 1ns/1ps

import RISCV_pkg::*;

module LW_Stall_Unit(
  input logic clk, 
  input logic rst,
  input logic [4:0] RS1_2,RS2_2,RD_3,
  input logic D_RD,
  output logic Stall
);

  always_comb begin
    if (D_RD && ((RS1_2 == RD_3) || (RS2_2 == RD_3)))
      Stall = 1'b0;
    else
      Stall = 1'b1;
  end

  //for initialising
  always_ff  @ (posedge rst) begin
    if (rst)
      Stall <= 1'b1;  
  end

endmodule

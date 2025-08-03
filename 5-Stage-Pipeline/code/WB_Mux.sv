`timescale 1ns/1ps

import RISCV_pkg::*;

module WB_Mux(
  input logic clk,
  input logic rst,
  input word_t ALU_Out_5,
  input word_t Data_Out_5,
  input logic D_RD_5,
  input logic WR_5,
  output word_t Write_Data
);
  always_comb begin
    if(D_RD_5)
      Write_Data = Data_Out_5;
    else
      Write_Data = WR_5 ? ALU_Out_5 : Data_Out_5;
  end
endmodule

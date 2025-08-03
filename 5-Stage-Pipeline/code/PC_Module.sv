`timescale 1ns/1ps

import RISCV_pkg::*;

module PC_Module(
  input logic clk,
  input logic rst,
  input word_t PC_B_J,
  input logic PC_Src,
  input word_t PC_Out_2,
  input logic Stall,
  output word_t PC_Out_1
);

  word_t PC_4;
  word_t PC_4_B_J;
  word_t PC_In;

  assign PC_4 = PC_Out_1 + 4;
  assign PC_4_B_J = PC_Src ? PC_B_J : PC_4;
  assign PC_In = Stall ? PC_4_B_J : (PC_Out_2 + 4);

  always_ff @ (posedge clk or posedge rst) begin
    if (rst)
      PC_Out_1 <= 0;
    else
      PC_Out_1 <= PC_In;
  end
endmodule

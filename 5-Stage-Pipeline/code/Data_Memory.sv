`timescale 1ns/1ps

import RISCV_pkg::*;

module Data_Memory(
  input logic clk,         //clock
  input logic rst,         //reset
  input word_t ALU_Out_4,  
  input word_t RD_2_4,     
  input logic D_RD_4,      
  input logic D_WR_4,      
  output word_t Data_Out_4 
);

  logic [7:0] Memory [31:0];//8 word storage capacity

  initial begin
    {Memory[3],  Memory[2],  Memory[1],  Memory[0]}   = 32'b0 ;
    {Memory[7],  Memory[6],  Memory[5],  Memory[4]}   = 32'b0 ; 
    {Memory[11], Memory[10], Memory[9],  Memory[8]}   = 32'b0 ;
    {Memory[15], Memory[14], Memory[13], Memory[12]}  = 32'b0 ;
    {Memory[19], Memory[18], Memory[17], Memory[16]}  = 32'b0 ;
    {Memory[23], Memory[22], Memory[21], Memory[20]}  = 32'b0 ;
    {Memory[27], Memory[26], Memory[25], Memory[24]}  = 32'b0 ;
    {Memory[31], Memory[30], Memory[29], Memory[28]}  = 32'b0 ;
  end

  always_ff @(posedge clk or posedge rst)begin
    if(rst) begin
      for (int i = 0; i < 32; i++) begin
        Memory[i] <= 8'd0;
      end
    end
    if(D_WR_4)begin
      //little endian format
      Memory[ALU_Out_4]     <= RD_2_4[7:0];
      Memory[ALU_Out_4+1]   <= RD_2_4[15:8];
      Memory[ALU_Out_4+2]   <= RD_2_4[23:16];
      Memory[ALU_Out_4+3]   <= RD_2_4[31:24]; 
    end
  end

  always_comb begin
    if(D_RD_4) begin
      Data_Out_4 = {Memory[ALU_Out_4+3], Memory[ALU_Out_4+2], Memory[ALU_Out_4+1], Memory[ALU_Out_4]};
    end
  end

endmodule

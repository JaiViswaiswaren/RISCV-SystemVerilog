`timescale 1ns/1ps

import RISCV_pkg::*;

module Register_File(
  input logic clk,         //clock
  input logic rst,         //reset
  input logic [4:0] RS1_2,RS2_2,RD_5,
  input logic WR_5,
  input word_t Write_Data,
  output word_t RD_1_2,RD_2_2
);
  logic [31:0] regmem [31:0];

  initial begin
    regmem[0] = 32'd0;
    regmem[1] = 32'd0;
    regmem[2] = 32'd0;
    regmem[3] = 32'd0;
    regmem[4] = 32'd0;
    regmem[5] = 32'h0000_0005;
    regmem[6] = 32'd0;
    regmem[7] = 32'd0;
    regmem[8] = 32'd0;
    regmem[9] = 32'd0;
    for (int i = 10; i < 32; i++) begin
      regmem[i] = 32'd0;
    end
  end

  always_ff @(posedge clk or posedge rst) begin 
    if(rst) begin
      for (int i = 10; i < 32; i++) begin// i am reseting only from r10 to r32, 
        //becz if i didnt do so , then  all my initial values of my register will be gone
        regmem[i] <= 32'd0;
      end
    end else if(WR_5 && RD_5 != 5'd0 ) begin//becz r0 cant be written always
      regmem[RD_5] <= Write_Data;
    end    
  end  
  //read combinational
  always_comb begin 
    RD_1_2 = regmem[RS1_2];
    RD_2_2 = regmem[RS2_2]; 
  end

endmodule

`timescale 1ns/1ps
 
import RISCV_pkg::*;

module Instruction_Memory(
  input logic clk,         //clock
  input logic rst,         //reset
  input word_t pc_out,     //from pc
  output word_t instruction//to regfile, controlunit, alucontrol, immblock
);

  logic [7:0] Memory [31:0];//8 instructions storage capacity
 
  initial begin
// Instruction 1 addi x1,x0,-3
    {Memory[3],  Memory[2],  Memory[1],  Memory[0]}   = 32'hFFD00093 ;
// Instruction 2 xor x4,x5,x1
    {Memory[7],  Memory[6],  Memory[5],  Memory[4]}   = 32'h0012C233 ;
// Instruction 3 beq x1,x4,+8
    {Memory[11], Memory[10], Memory[9],  Memory[8]}   = 32'h00120463 ;
// Instruction 4 jal x0,+8
    {Memory[15], Memory[14], Memory[13], Memory[12]}  = 32'h0080006F ;
// Instruction 5 addi x9,x9,100
    {Memory[19], Memory[18], Memory[17], Memory[16]}  = 32'h06448493 ;
// Instruction 6 sw x5,0(x0)
    {Memory[23], Memory[22], Memory[21], Memory[20]}  = 32'h00502023 ;
// Instruction 7 lw x6,0(x0)
    {Memory[27], Memory[26], Memory[25], Memory[24]}  = 32'h00002303 ;
// Instruction 8 add x7,x6,x1
    {Memory[31], Memory[30], Memory[29], Memory[28]}  = 32'h001303B3 ;
  end

always_comb begin
  instruction = {Memory[pc_out+3],  Memory[pc_out+2],  Memory[pc_out+1],  Memory[pc_out+0]};
end  
endmodule
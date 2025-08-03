`timescale 1ns/1ps
 
import RISCV_pkg::*;

module Register_File(
  input logic clk,         //clock
  input logic rst,         //reset
  input word_t instruction,//from instruction memory
  input word_t write_data, //from data memory
  input logic reg_wr,      //from control unit
  output word_t rd1,       //to alu
  output word_t rd2        //to alu 
);
logic [4:0] rs1,rs2,rd;
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
//instruction assigning
  always @(*) begin 
  rs1 = instruction[19:15];
  rs2 = instruction[24:20];
  rd  = instruction[11:7];
end
  
//write on posedge
always_ff @(posedge clk or posedge rst) begin 
  if(rst) begin
    for (int i = 10; i < 32; i++) begin// i am reseting only from r10 to r32, 
//becz if i didnt do so , then  all my initial values of my register will be gone
      regmem[i] <= 32'd0;
  	end
  end else if(reg_wr && rd != 5'd0 ) begin//becz r0 cant be written always
    regmem[rd] <= write_data;
  end    
end  
//read combinational
  always @(*) begin 
   	rd1 = regmem[rs1];
    rd2 = regmem[rs2]; 

   //rd1 = (rs1 == 5'd0) ? 32'd0 : regmem[rs1];  //r0 hardwiring
   //rd2 = (rs2 == 5'd0) ? 32'd0 : regmem[rs2];  //r0 hardwiring
end
endmodule

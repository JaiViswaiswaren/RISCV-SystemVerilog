//testbench
`timescale 1ns/1ps
import RISCV_pkg::*;


module topg;

  logic clk,rst,ALU_zero,reg_wr,alu_src,mem_reg,mem_wr,mem_rd;
  logic [1:0] pc_src,alu_op;
  logic [2:0] alu_ctrl;
  logic [6:0] opcode;
  logic [31:0] imm32,pc_out,instruction,write_data,rd1,rd2,ALU_out32;
  
  // Clock Generation: 10ns period
  initial clk = 1;
  always #10 clk = ~clk;
  
PC u1 (
  .clk(clk),
  .rst(rst),
  .imm32(imm32),
  .pc_src(pc_src),
  .ALU_zero(ALU_zero),
  .pc_out(pc_out)
);

Instruction_Memory u2 (
  .clk(clk),
  .rst(rst),
  .pc_out(pc_out),
  .instruction(instruction)
);

Register_File u3 (
  .clk(clk),
  .rst(rst),
  .instruction(instruction),
  .write_data(write_data),
  .reg_wr(reg_wr),
  .rd1(rd1),
  .rd2(rd2)
);

Imm_Block u4 (
  .clk(clk),
  .rst(rst),
  .instruction(instruction),
  .imm32(imm32)
);

Control_Unit u5 (
  .clk(clk),
  .rst(rst),
  .instruction(instruction),
  .alu_op(alu_op),
  .pc_src(pc_src),
  .reg_wr(reg_wr),
  .alu_src(alu_src),
  .mem_reg(mem_reg),
  .mem_wr(mem_wr),
  .mem_rd(mem_rd)
);

ALU_Control u6 (
  .clk(clk),
  .rst(rst),
  .instruction(instruction),
  .alu_op(alu_op),
  .alu_ctrl(alu_ctrl)
);

ALU u7 (
  .alu_ctrl(alu_ctrl),
  .rd1(rd1),
  .rd2(rd2),
  .imm32(imm32),
  .alu_src(alu_src),
  .ALU_zero(ALU_zero),
  .ALU_out32(ALU_out32)
);

Data_Memory u8 (
  .clk(clk),
  .rst(rst),
  .ALU_out32(ALU_out32),
  .rd2(rd2),
  .mem_wr(mem_wr),
  .mem_rd(mem_rd),
  .mem_reg(mem_reg),
  .write_data(write_data)
);
initial begin
    $dumpfile("dump.vcd");
	$dumpvars;
end
initial begin
 rst = 1;
#5rst =0;
#200 $finish;
end

endmodule

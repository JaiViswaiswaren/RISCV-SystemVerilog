//testbench
`timescale 1ns/1ps
import RISCV_pkg::*;


module topg;

  logic clk, rst, reg_rst, Stall, WR, ALU_Src, BEQ, BEQ_3 , BEQ_J_3 , BEQ_J,PC_Src, zero, ALU_Src_3,WR_4,WR_5,WR_3, D_RD, D_WR, D_RD_3, D_WR_3, D_RD_4, D_WR_4,D_RD_5 ;
  logic [1:0] alu_op, Sel_B, Sel_A;
  logic [2:0] alu_ctrl, ALU_Ctrl_3;
  logic [4:0] RS1_2, RS2_2, RD_2, RD_3, RD_4, RD_5,RS1_3, RS2_3;
  logic [31:0] Instruction_1, Instruction_2, imm32_2, imm32_3,PC_Out_1, PC_Out_2, PC_Out_3, ALU_Out_3, ALU_Out_4, ALU_Out_5, Write_Data, Data_Out_4, Data_Out_5,PC_B_J,RD_1_2, RD_1_3, RD_2_3, RD_2_4,RD_2_2; 



  // Clock Generation: 10ns period
  initial clk = 1;
  always #10 clk = ~clk;

  PC_Module utt1 (
    .clk(clk),
    .rst(rst),
    .PC_B_J(PC_B_J),
    .PC_Src(PC_Src),
    .PC_Out_2(PC_Out_2),
    .Stall(Stall),
    .PC_Out_1(PC_Out_1)
  );

  Instruction_Memory utt2 (
    .clk(clk),
    .rst(rst),
    .PC_Out_1(PC_Out_1),
    .Instruction_1(Instruction_1)
  );

  IF_ID_REG utt3 (
    .clk(clk),
    .rst(rst),
    .reg_rst(reg_rst),
    .Instruction_1(Instruction_1),
    .PC_Out_1(PC_Out_1),
    .Instruction_2(Instruction_2),
    .RS1_2(RS1_2),
    .RS2_2(RS2_2),
    .RD_2(RD_2),
    .PC_Out_2(PC_Out_2)
  );

  Control_Unit utt4 (
    .clk(clk),
    .rst(rst),
    .Instruction_2(Instruction_2),
    .alu_op(alu_op),
    .WR(WR),
    .ALU_Src(ALU_Src),
    .BEQ(BEQ),
    .BEQ_J(BEQ_J),
    .D_RD(D_RD),
    .D_WR(D_WR)
  );

  ALU_Control utt5 (
    .clk(clk),
    .rst(rst),
    .Instruction_2(Instruction_2),
    .alu_op(alu_op),
    .alu_ctrl(alu_ctrl)
  );

  Imm_Block utt6 (
    .clk(clk),
    .rst(rst),
    .Instruction_2(Instruction_2),
    .imm32_2(imm32_2)
  );

  Register_File utt7 (
    .clk(clk),
    .rst(rst),
    .RS1_2(RS1_2),
    .RS2_2(RS2_2),
    .RD_5(RD_5),
    .WR_5(WR_5),
    .Write_Data(Write_Data),
    .RD_1_2(RD_1_2),
    .RD_2_2(RD_2_2)
  );

  LW_Stall_Unit utt8 (
    .clk(clk),
    .rst(rst),
    .RS1_2(RS1_2),
    .RS2_2(RS2_2),
    .RD_3(RD_3),
    .D_RD(D_RD),
    .Stall(Stall)
  );

  ID_EX_REG utt9 (
    .clk(clk),
    .rst(rst),
    .reg_rst(reg_rst),
    .imm32_2(imm32_2),
    .RD_1_2(RD_1_2),
    .RD_2_2(RD_2_2),
    .RS1_2(RS1_2),
    .RS2_2(RS2_2),
    .RD_2(RD_2),
    .PC_Out_2(PC_Out_2),
    .WR(WR),
    .ALU_Src(ALU_Src),
    .BEQ(BEQ),
    .BEQ_J(BEQ_J),
    .D_RD(D_RD),
    .D_WR(D_WR),
    .alu_ctrl(alu_ctrl),
    .imm32_3(imm32_3),
    .RD_1_3(RD_1_3),
    .RD_2_3(RD_2_3),
    .RS1_3(RS1_3),
    .RS2_3(RS2_3),
    .RD_3(RD_3),
    .PC_Out_3(PC_Out_3),
    .WR_3(WR_3),
    .ALU_Src_3(ALU_Src_3),
    .BEQ_3(BEQ_3),
    .BEQ_J_3(BEQ_J_3),
    .D_RD_3(D_RD_3),
    .D_WR_3(D_WR_3),
    .ALU_Ctrl_3(ALU_Ctrl_3)
  );

  BEQ_J_Unit utt10 (
    .clk(clk),
    .rst(rst),
    .imm32_3(imm32_3),
    .PC_Out_3(PC_Out_3),
    .BEQ_3(BEQ_3),
    .BEQ_J_3(BEQ_J_3),
    .zero(zero),
    .reg_rst(reg_rst),
    .PC_Src(PC_Src),
    .PC_B_J(PC_B_J)
  );

  ALU_Unit utt11 (
    .ALU_ctrl_3(ALU_Ctrl_3),
    .RD_1_3(RD_1_3),
    .RD_2_3(RD_2_3),
    .imm32_3(imm32_3),
    .ALU_Out_4(ALU_Out_4),
    .Write_Data(Write_Data),
    .Sel_A(Sel_A),
    .Sel_B(Sel_B),
    .zero(zero),
    .ALU_out_3(ALU_Out_3)
  );

  Forward_Unit utt12 (
    .ALU_Src_3(ALU_Src_3),
    .RS1_3(RS1_3),
    .RS2_3(RS2_3),
    .RD_4(RD_4),
    .RD_5(RD_5),
    .Sel_A(Sel_A),
    .Sel_B(Sel_B)
  );

  EX_M_REG utt13 (
    .clk(clk),
    .rst(rst),
    .reg_rst(reg_rst),
    .D_RD_3(D_RD_3),
    .D_WR_3(D_WR_3),
    .WR_3(WR_3),
    .ALU_Out_3(ALU_Out_3),
    .RD_2_3(RD_2_3),
    .RD_3(RD_3),
    .D_RD_4(D_RD_4),
    .D_WR_4(D_WR_4),
    .WR_4(WR_4),
    .ALU_Out_4(ALU_Out_4),
    .RD_2_4(RD_2_4),
    .RD_4(RD_4)
  );

  Data_Memory utt14 (
    .clk(clk),
    .rst(rst),
    .ALU_Out_4(ALU_Out_4),
    .RD_2_4(RD_2_4),
    .D_RD_4(D_RD_4),
    .D_WR_4(D_WR_4),
    .Data_Out_4(Data_Out_4)
  );

  M_WB_REG utt15 (
    .clk(clk),
    .rst(rst),
    .reg_rst(reg_rst),
    .WR_4(WR_4),
    .ALU_Out_4(ALU_Out_4),
    .Data_Out_4(Data_Out_4),
    .RD_4(RD_4),
    .WR_5(WR_5),
    .ALU_Out_5(ALU_Out_5),
    .Data_Out_5(Data_Out_5),
    .RD_5(RD_5),
    .D_RD_4(D_RD_4),
    .D_RD_5(D_RD_5)
  );

  WB_Mux utt16 (
    .clk(clk),
    .rst(rst),
    .ALU_Out_5(ALU_Out_5),
    .Data_Out_5(Data_Out_5),
    .WR_5(WR_5),
    .Write_Data(Write_Data),
    . D_RD_5 (D_RD_5 )
  );

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  initial begin
    rst = 0;#1
    rst = 1;
    #5rst =0;
    #600 $finish;
  end



endmodule

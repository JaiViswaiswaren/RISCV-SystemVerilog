`timescale 1ns/1ps

package RISCV_pkg;
  
typedef logic [31:0] word_t;  //for defining a 32 bit value

typedef logic [4:0] reg_t;  //for defining a 5 bit value

typedef enum logic [1:0] {
        PC_4 = 2'b00,      // pc + 4 for no branch
        PC_B = 2'b01,      // pc + imm for branch
        PC_J = 2'b10       // pc + imm for jal/jalr
}pc_src_t;

typedef enum logic [6:0] {
		R_Type = 7'b0110011,
  		I_Type = 7'b0010011,
        LW     = 7'b0000011,
  		SW     = 7'b0100011,
  		BEQ    = 7'b1100011,
  		J      = 7'b1101111
}opcode_t;

typedef enum logic [2:0] {
  		AND = 3'b000,
  		OR  = 3'b001,
  		XOR = 3'b010,
  		SUB = 3'b110,
  		ADD = 3'b111
}alu_ctrl_t;

endpackage

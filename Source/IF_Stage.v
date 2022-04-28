module IF_Stage (input clk, rst, branch_tacken, input [31:0]branch_address, input freeze, output [31:0]pc, instruction);
  
  wire [31:0] switch, pc_out;
  
  assign pc = pc_out + 4;
  assign switch = branch_tacken ? branch_address : pc;
  
  PC pc_reg (clk, rst, switch, freeze, pc_out);
  Instruction_mem instruction_memory (clk, rst, pc_out, instruction);

endmodule

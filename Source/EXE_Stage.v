module EXE_Stage (input clk, rst, input [3:0] exe_cmd,
  input wb_en_in, mem_r_en_in, mem_w_en_in, input [31:0] pc_in, val_rn, val_rm, input imm, input [11:0] shift_operand,
  input [23:0]imm_signed_24, input [3:0]sr, dest_in, input [1:0]sel_src_1, sel_src_2,
  input [31:0]mem_val, wb_val, output wb_en, mem_r_en, mem_w_en,
  output [31:0]alu_result, br_addr, output [3:0] status, output [31:0] val_rm_out, output [3:0]dest);
  
  wire or_output;
  wire [31:0] val_2, forwarding_val_1, forwarding_val_2;
  assign dest = dest_in;
  assign wb_en = wb_en_in;
  assign val_rm_out = val_rm;
  assign mem_r_en = mem_r_en_in;
  assign mem_w_en = mem_w_en_in;
  assign or_output = mem_w_en_in || mem_r_en_in;
  assign br_addr = ({{8{imm_signed_24[23]}}, {imm_signed_24}} << 2) + pc_in;

  MUX mux1 (clk, rst, val_rm, mem_val, wb_val, sel_src_2, forwarding_val_2);
  MUX mux2 (clk, rst, val_rn, mem_val, wb_val, sel_src_1, forwarding_val_1);
  ALU alu (clk, rst, forwarding_val_1, val_2, exe_cmd, sr, alu_result, status);
  Val2Generator val_2_generator (clk, rst, forwarding_val_2, shift_operand, imm, or_output, val_2);

endmodule

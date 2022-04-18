module MEM_Stage ( input clk, rst, wb_en_in, mem_r_en_in, mem_w_en_in,
  input [31:0]alu_result, rm_val, input [3:0]dest_in, output wb_en, mem_r_en, mem_w_en,
  output [31:0]alu_result_out, data_memory_out, output [3:0]dest);

  assign dest = dest_in;
  assign wb_en = wb_en_in;
  assign mem_r_en = mem_r_en_in;
  assign mem_w_en = mem_w_en_in;
  assign alu_result_out = alu_result; 
  
  DataMemory data_memory (clk, rst, mem_r_en_in, mem_w_en_in, alu_result, rm_val, data_memory_out);

endmodule

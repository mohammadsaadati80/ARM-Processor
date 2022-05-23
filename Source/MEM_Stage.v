module MEM_Stage (input clk, rst, wb_en_in, mem_r_en_in, mem_w_en_in,
  input [31:0]alu_result, rm_val, input [3:0]dest_in, output wb_en, mem_r_en, mem_w_en,
  output [31:0]alu_result_out, data_memory_out, output [3:0]dest, inout [15:0]sram_dq,
  output sram_w_en, output [17:0]sram_address, output ready);

  assign dest = dest_in;
  assign wb_en = wb_en_in;
  assign mem_r_en = mem_r_en_in;
  assign mem_w_en = mem_w_en_in;
  assign alu_result_out = alu_result; 
  
  SRAM_Controller sc (clk, rst, mem_r_en_in, mem_w_en_in, alu_result, rm_val, sram_dq, sram_w_en, data_memory_out, sram_address, ready);
  // Data_Memory data_memory (clk, rst, mem_r_en_in, mem_w_en_in, alu_result, rm_val, data_memory_out);

endmodule

module MEM_Stage (input clk, rst, wb_en_in, mem_r_en_in, mem_w_en_in,
  input [31:0]alu_result, rm_val, input [3:0]dest_in, output wb_en, mem_r_en, mem_w_en,
  output [31:0]alu_result_out, data_memory_out, output [3:0]dest, inout [15:0]sram_dq,
  output SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N, output [17:0]sram_address, output ready);

  wire [63:0] sram_read_data;
  wire [31:0] cache_sram_address, cache_sram_wdata;
  wire cache_read, cache_write, cache_ready, sram_ready;

  assign dest = dest_in;
  assign wb_en = wb_en_in;
  assign mem_r_en = mem_r_en_in;
  assign mem_w_en = mem_w_en_in;
  assign alu_result_out = alu_result;

  assign ready = cache_ready | sram_ready;
  
  SRAM_Controller sc(clk, rst, cache_write, cache_read, cache_sram_address, cache_sram_wdata, sram_read_data, sram_ready, sram_dq, sram_address,
                    SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N);

  Cache_Controller cc(.clk(clk), .rst(rst), .MEM_R_EN(mem_r_en_in), .MEM_W_EN(mem_w_en_in), .Address(alu_result), .wdata(rm_val), .rdata(data_memory_out),
                      .sram_rdata(sram_read_data), .sram_ready(sram_ready), .ready(cache_ready), .sram_address(cache_sram_address),
                      .sram_wdata(cache_sram_wdata), .write(cache_write), .read(cache_read));

  // SRAM_Controller sc(clk, rst, mem_w_en_in, mem_r_en_in, alu_result, rm_val, data_memory_out, ready, sram_dq,
  //   sram_address, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N);

  // Data_Memory data_memory (clk, rst, mem_r_en_in, mem_w_en_in, alu_result, rm_val, data_memory_out);

endmodule

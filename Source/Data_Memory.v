module Data_Memory (input clk, rst, mem_r_en, mem_w_en,
  input [31:0]address, data, output [31:0] data_memory_out);
  
  reg [31:0] memory[0:64];
  wire [31:0] aligned_address;
  assign aligned_address = ((address - 1024) >> 2);

  always @ (posedge clk, posedge rst) begin
    if (rst) begin end
    else if (mem_w_en) memory[aligned_address] <= data;
  end

  assign data_memory_out = (mem_r_en) ? memory[aligned_address] : data_memory_out;
  
endmodule

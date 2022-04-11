module Data_Memory(input clk, rst, mem_r_en, mem_w_en, input [31:0]address, data,
    output reg [31:0]data_memory_out);
  
    reg [31:0] memory[0:64];
  
    wire [31:0] aligned_address;
    assign aligned_address = ((address - 1024) >> 2);

    always @ (*) begin
        if (mem_r_en) data_memory_out = memory[aligned_address];
    end
  
    always @ (posedge clk, posedge rst) begin
        if (mem_w_en) memory[aligned_address] <= data;
    end
endmodule

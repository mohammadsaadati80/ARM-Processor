// This moduls is a mock module to test code in modelsim
// On real FPGA we use real SRAM instead of this module
`timescale 1ps/1ps

module SRAM (input clk, rst, sram_we_n, input [17:0]sram_address, inout [15:0]sram_dq);
  
  reg [31:0]memory[0:511];
  
  assign #10 sram_dq = sram_we_n ? memory[sram_address] : 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;
  
  always @ (posedge clk) begin
    if (!sram_we_n) memory[sram_address] = sram_dq;
  end

endmodule

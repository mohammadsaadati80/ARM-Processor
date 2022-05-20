// This moduls is a  mocking module to test code in modelsim
// On real FPGA we use real SRAM instead of this module

module SRAM (input clk, rst, sram_we_n, input [16:0]sram_address, inout [31:0]sram_dq);
  
  reg [31:0] memory[0:511];
  
  assign #30 sram_dq = sram_we_n ? memory[sram_address] : 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;
  
  always @ (posedge clk) begin
    if (!sram_we_n) memory[sram_address] = sram_dq;
  end

endmodule

// This moduls is a mock module to test code in modelsim
// On real FPGA we use real SRAM instead of this module
module SRAM(inout [15:0]SRAM_DQ, input [17:0]SRAM_ADDR,
  input SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N);

  wire [8:0] address_t;
  reg [15:0] data[0:511];

  assign address_t = SRAM_ADDR[8:0];
  assign SRAM_DQ = SRAM_WE_N ? data[SRAM_ADDR]: 16'bz;

  always @(*) if (SRAM_WE_N == 1'b0) data[address_t] <= SRAM_DQ;

endmodule

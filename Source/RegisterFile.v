module RegisterFile (input clk, rst, input [3:0]src_1, src_2, dest_wb, input [31:0]result_wb,
  input write_back_en, output [31:0]reg_1, reg_2);
  
  reg [31:0] registers [0:14];
  assign reg_1 = registers[src_1];
  assign reg_2 = registers[src_2];
  
  always @ (negedge clk) begin
    if (write_back_en) registers[dest_wb] <= result_wb;
  end

  integer i;
  always @ (posedge rst) begin
    if (rst) for (i = 0; i < 15; i=i+1) registers[i] <= i;
  end
  
endmodule

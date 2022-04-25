module RegisterFile (input clk, rst, input [3:0]src_1, src_2, dest_wb, input [31:0]result_wb,
  input write_back_en, output [31:0]reg_1, reg_2);
  
  reg [31:0] registers [0:14];
  assign reg_1 = registers[src_1];
  assign reg_2 = registers[src_2];
  
  integer i;
  always @ (negedge clk, posedge rst) begin
    if (rst) for (i = 0; i < 15; i=i+1) registers[i] <= i;
    else if (write_back_en) registers[dest_wb] <= result_wb;
  end
  
  initial begin
    registers[0] = 0;
	 registers[1] = 1;
	 registers[2] = 2;
	 registers[3] = 3;
	 registers[4] = 4;
	 registers[5] = 5;
	 registers[6] = 6;
	 registers[7] = 7;
	 registers[8] = 8;
	 registers[9] = 9;
	 registers[10] = 10;
	 registers[11] = 11;
	 registers[12] = 12;
	 registers[13] = 13;
	 registers[14] = 14;
  end
  
endmodule

module SRAM_Controller(input clk, rst, write_enable, read_enable, input [31:0]address, write_data,
  output [31:0]read_data, output ready, inout [15:0]SRAM_DQ, output [17:0]SRAM_ADDR,
  output SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N);

  assign SRAM_UB_N = 1'b0;
  assign SRAM_LB_N = 1'b0;
  assign SRAM_CE_N = 1'b0;
  assign SRAM_OE_N = 1'b0;

  wire [1:0]ps, ns;
  wire [2:0]sram_counter, next_sram_counter;
  parameter IDLE = 2'b00, READ_STATE = 2'b01, WRITE_STATE = 2'b10;

  wire [31:0]read_data_local;
  wire [31:0]address4k = {address[31:2], 2'b0} - 32'd1024;    
  wire [31:0]address4k_div_2 = {1'b0, address4k[31:1]};

  register #2 state(clk, rst, ns, ps);
  register #32 data(clk, rst, read_data_local, read_data);
  register #3 counter(clk, rst, next_sram_counter, sram_counter);

  assign ready = rst ? 1'b1
    : (((ps == IDLE) && (read_enable == 1'b1 || write_enable == 1'b1)) ? 1'b0
    :   (ps == IDLE) ? 1'b1
    :   (ps == READ_STATE && (sram_counter == 3'd6)) ? 1'b1
    :   (ps == READ_STATE) ? 1'b0
    :   (ps == WRITE_STATE && (sram_counter == 3'd6)) ? 1'b1
    :   (ps == WRITE_STATE) ? 1'b0
    : 1'b1);

  assign next_sram_counter = (ps == IDLE) ? 3'd0
    : (ps == READ_STATE && sram_counter == 3'd6) ? 3'd0
    : (ps == READ_STATE) ? sram_counter + 3'd1
    : (ps == WRITE_STATE && sram_counter == 3'd6) ? 3'd0
    : (ps == WRITE_STATE) ? sram_counter + 3'd1
    : 3'd0;

  assign ns = (rst == 1'b1) ? IDLE
    : ((ps == IDLE && read_enable == 1'b1) ? READ_STATE
    : (ps == IDLE && write_enable == 1'b1) ? WRITE_STATE
    : (ps == IDLE) ? IDLE
    : (ps == READ_STATE && (sram_counter == 3'd6)) ? IDLE
    : (ps == READ_STATE) ? READ_STATE
    : (ps == WRITE_STATE && (sram_counter == 3'd6)) ? IDLE
    : (ps == WRITE_STATE) ? WRITE_STATE
    : IDLE);

  assign SRAM_DQ = 
      (ps == WRITE_STATE && (sram_counter == 3'd0)) ? write_data[31:16]
    : (ps == WRITE_STATE && (sram_counter == 3'd1)) ? write_data[31:16]
    : (ps == WRITE_STATE && (sram_counter == 3'd2)) ? write_data[15:0]
    : (ps == WRITE_STATE && (sram_counter == 3'd3)) ? write_data[15:0]
    : 16'bz;

  assign SRAM_ADDR = 
      (ps == READ_STATE && (sram_counter == 3'd1)) ? {address4k_div_2[17:1], 1'b0}
    : (ps == READ_STATE && (sram_counter == 3'd2)) ? {address4k_div_2[17:1], 1'b0}
    : (ps == READ_STATE && (sram_counter == 3'd3)) ? {address4k_div_2[17:1], 1'b1}
    : (ps == READ_STATE && (sram_counter == 3'd4)) ? {address4k_div_2[17:1], 1'b1}
    : (ps == WRITE_STATE && (sram_counter == 3'd0)) ? {address4k_div_2[17:1], 1'b0}
    : (ps == WRITE_STATE && (sram_counter == 3'd1)) ? {address4k_div_2[17:1], 1'b0}
    : (ps == WRITE_STATE && (sram_counter == 3'd2)) ? {address4k_div_2[17:1], 1'b1}
    : (ps == WRITE_STATE && (sram_counter == 3'd3)) ? {address4k_div_2[17:1], 1'b1}
    : 18'b0;
  
  assign SRAM_WE_N = 
      (ps == WRITE_STATE && (sram_counter == 3'd1)) ? 1'b0
    : (ps == WRITE_STATE && (sram_counter == 3'd3)) ? 1'b0
    : 1'b1;

  assign read_data_local =
      (ps == READ_STATE && (sram_counter == 3'd2)) ? {SRAM_DQ, read_data[15:0]}
    : (ps == READ_STATE && (sram_counter == 3'd4)) ? {read_data[31:16], SRAM_DQ}
    : read_data;

endmodule


module register(clk, rst, in, out);

	parameter N = 32;
  input clk, rst;
  input [N-1:0]in;
  output reg[N-1:0]out;
 
	always@(posedge clk, posedge rst) begin
		if (rst) out <= 0;
		else out <= in;
	end
	
endmodule

module SRAM_Controller (input clk, rst, read_en, write_en, input [31:0]address, input [31:0]write_data,
    inout [31:0]sram_dq, output sram_w_en, output [31:0]read_data, output [17:0]sram_address, output ready);
  
  reg [1:0]ps, ns;
  reg [2:0]counter;
  
  wire [31:0]data_address;

  assign read_data = sram_dq;
  assign data_address = address - 1024;
  assign sram_address = data_address[18:2];
  assign sram_w_en = ((ns == 2'b10) && (counter < 3'b100)) ? 1'b0 : 1'b1;
  assign sram_dq = ((ns == 2'b10) && (counter < 3'b100)) ? write_data : 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;

  assign ready = ((ns == 2'b01) && (counter < 3'b100)) ? 1'b0 :
                 ((ns == 2'b10) && (counter < 3'b100)) ? 1'b0 :
                 1'b1;

  always @ (posedge clk, posedge rst) begin
    if (rst) counter <= 3'b000;
    else begin
      if (((ps == 2'b01) || (ps == 2'b10)) && (counter < 3'b100))
        counter <= counter + 3'b001;
      else counter <= 3'b000;
    end
  end

  always @ (ps, read_en, write_en, counter) begin
    case (ps)
      2'b00: ns = read_en ? 2'b01 : (write_en ? 2'b10 : 2'b00);
      2'b01: ns = (counter < 3'b100) ? 2'b01 : 2'b00;
      2'b10: ns = (counter < 3'b100) ? 2'b10 : 2'b00;
    endcase
  end

  always @ (posedge clk, posedge rst) begin
    if (rst) ps <= 2'b00;
    else ps <= ns;
  end

endmodule

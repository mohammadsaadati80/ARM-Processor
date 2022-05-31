module SRAM_Controller (input clk, rst, wr_en, rd_en,
  input [31:0]address, writeData, output reg [31:0]readData,
  output ready, inout [15:0] SRAM_DQ, output [17:0]SRAM_ADDR,
  output reg SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N);


  reg [2:0]ps, ns;
  wire [31:0]address_t;
  reg [15:0]SRAM_DQ_reg;
  reg [17:0]SRAM_ADDR_reg;
  wire [17:0]address1, address2;
  
  parameter one = 3'd0, two = 3'd1, three = 3'd2, four = 3'd3, five = 3'd4;

  assign address_t = address - 1024;
  assign address1 = {address_t[17:1], 1'b0};
  assign address2 = {address_t[17:1], 1'b1};

  always @ (posedge clk) begin
    SRAM_UB_N = 0 ; SRAM_LB_N = 0 ; SRAM_CE_N = 0 ; SRAM_OE_N = 0 ; SRAM_WE_N = 1;
    case(ps)
      one: begin
        if(wr_en) begin SRAM_DQ_reg <= writeData[31:16]; SRAM_ADDR_reg <= address2; SRAM_WE_N <= 1'b0; end
        else if(rd_en) begin readData[15:0] <= SRAM_DQ; end
      end
      two: begin
        if(wr_en) begin SRAM_DQ_reg <= writeData[15:0]; SRAM_ADDR_reg <= address1; SRAM_WE_N <= 1'b0; end
        else if(rd_en) begin readData[31:16] <= SRAM_DQ; end
      end
    endcase
  end

  always @ (ps) begin
    if(ps == five) ns = one;
    else ns = ps + 1;
  end

  always @ (posedge clk) begin
    if(rst | (!wr_en & !rd_en)) ps <= one;
    else ps <= ns;
  end

  assign SRAM_DQ = (wr_en) ? SRAM_DQ_reg : 16'bzzzzzzzzzzzzzzzz;
  assign ready = ((ps == one || ps == four || ps == three || ps == two) && (wr_en | rd_en)) ? 0 : 1;
  assign SRAM_ADDR = (wr_en) ? SRAM_ADDR_reg :
                 (ps == one) ? address1 :
                 (ps == two) ? address2 : 16'b0;

endmodule
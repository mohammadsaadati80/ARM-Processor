module SRAM_Controller (input clk, rst, wr_en, rd_en,
  input [31:0]address, writeData, output reg [63:0]readData,
  output reg ready, inout [15:0]SRAM_DQ, output [17:0]SRAM_ADDR,
  output reg SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N);


  reg [2:0]ps, ns;
  wire [31:0]address_t;
  reg [15:0]SRAM_DQ_reg;
  reg [17:0]SRAM_ADDR_reg;
  wire [17:0]address1, address2, address3, address4, w_address1, w_address2;
  
  parameter one = 3'd0, two = 3'd1, three = 3'd2, four = 3'd3, five = 3'd4, six = 3'd5;

  assign address_t = address - 1024;

  assign w_address1 =  {address_t[18:2], 1'b0};
  assign w_address2 =  {address_t[18:2], 1'b1};

  assign address1 = {address_t[18:3], 2'b00};
  assign address2 = {address_t[18:3], 2'b01};
  assign address3 = {address_t[18:3], 2'b10};
  assign address4 = {address_t[18:3], 2'b11};

  always @ (posedge clk, ps) begin
    SRAM_UB_N = 0 ; SRAM_LB_N = 0 ; SRAM_CE_N = 0 ; SRAM_OE_N = 0 ; SRAM_WE_N = 1; ready = 0;
    case(ps)
      one: begin
        if(wr_en) begin SRAM_DQ_reg <= writeData[31:16]; SRAM_ADDR_reg <= w_address2; SRAM_WE_N <= 1'b0; end
        else if(rd_en) begin readData[15:0] <= SRAM_DQ; end
      end
      two: begin
        if(wr_en) begin SRAM_DQ_reg <= writeData[15:0]; SRAM_ADDR_reg <= w_address1; SRAM_WE_N <= 1'b0; end
        else if(rd_en) begin readData[31:16] <= SRAM_DQ; end
      end
      three: begin
        if(rd_en) begin readData[47:32] <= SRAM_DQ; end
      end
      four: begin
        if(rd_en) begin readData[63:48] <= SRAM_DQ; end
        // ready <= 1; 
      end
      six: begin
        begin ready <= 1; end
      end
    endcase
  end

  always @ (ps) begin
    if(ps == six) ns = one;
    else ns = ps + 1;
  end

  always @ (posedge clk) begin
    if(rst) ps <= one;
    else ps <= ns;
  end

  assign SRAM_DQ = (wr_en) ? SRAM_DQ_reg : 16'bzzzzzzzzzzzzzzzz;
  // assign ready = ((!wr_en & !rd_en) | (((ps == one) || (ps == two) || (ps == three) || (ps == four)) && (wr_en | rd_en))) ? 0 : 1;
  assign SRAM_ADDR = (wr_en) ? SRAM_ADDR_reg :
                      (ps == one) ? address1 :
                      (ps == two) ? address2 :
                    (ps == three) ? address3 :
                     (ps == four) ? address4 : 16'b0;

endmodule

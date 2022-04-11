module Status_Register (input clk, rst, s, input [3:0]status_bits, output reg [3:0] sr);

  always @ (negedge clk, posedge rst) begin
    if (rst) sr <= 4'b0000;
    else if (s) sr <= status_bits;
  end

endmodule
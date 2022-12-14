module MUX(input clk, rst, input [31:0]a, b, c, input [1:0]s, output reg [31:0]out);
  
  always @ (a, b, c, s) begin
    out = 32'b00000000000000000000000000000000;
    if (s == 2'b00) out = a;
    else if (s == 2'b01) out = b;
    else out = c;
  end

endmodule
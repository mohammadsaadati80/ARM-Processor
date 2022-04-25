module Condition_Check (input [3:0]cond, sr, output reg result);

  wire z, c, n, v;  
  assign {z, c, n, v} = sr;
  
  always @ (cond, sr) begin
    result = 1'b0;
    case (cond)
      4'b0000: begin if (z == 1'b1) result = 1'b1; end
      4'b0001: begin if (z == 1'b0) result = 1'b1; end
      4'b0010: begin if (c == 1'b1) result = 1'b1; end
      4'b0011: begin if (c == 1'b0) result = 1'b1; end
      4'b0100: begin if (n == 1'b1) result = 1'b1; end
      4'b0101: begin if (n == 1'b0) result = 1'b1; end
      4'b0110: begin if (v == 1'b1) result = 1'b1; end
      4'b0111: begin if (v == 1'b0) result = 1'b1; end
      4'b1000: begin if ((c == 1'b1) && (z == 1'b0)) result = 1'b1; end
      4'b1001: begin if ((c == 1'b0) && (z == 1'b1)) result = 1'b1; end
      4'b1010: begin if (n == v) result = 1'b1; end
      4'b1011: begin if (n != v) result = 1'b1; end
      4'b1100: begin if ((z == 1'b0) && (n == v)) result = 1'b1; end
      4'b1101: begin if ((z == 1'b1) && (n != v)) result = 1'b1; end
      4'b1110: begin result = 1'b1; end
      default: result = 1'b0;
    endcase
  end
endmodule

module Condition_Check (
  input [3:0]   cond,
  input [3:0]   SR,
  output reg    cond_state_result
  );
  
  wire z, c, n, v; 
  
  assign {z, c, n, v} = SR;
  
  always @(cond, z, c, n, v) begin
    
    cond_state_result = 1'b0;

    case(cond)
            4'b0000 : cond_state_result = z;

            4'b0001 : cond_state_result = ~z;

            4'b0010 : cond_state_result = c;

            4'b0011 : cond_state_result = ~c;

            4'b0100 : cond_state_result = n;

            4'b0101 : cond_state_result = ~n;

            4'b0110 : cond_state_result = v;

            4'b0111 : cond_state_result = ~v;

            4'b1000 : cond_state_result = c & ~z;

            4'b1001 : cond_state_result = ~c | z;

            4'b1010 : cond_state_result = (n & v) | (~n & ~v);

            4'b1011 : cond_state_result = (n & ~v) | (~n & v);

            4'b1100 : cond_state_result = ~z & ((n & v) | (~n & ~v));

            4'b1101 : cond_state_result = z | (n & ~v) | (~n & ~v);

            4'b1110 : cond_state_result = 1'b1;

            default: cond_state_result = 1'b0;
            
        endcase
    end
  
endmodule
module ControlUnit(input [1:0]mode, input [3:0]Op_code, input S_in, output reg [3:0]Exe_Cmd,
	output reg mem_read, mem_write, WB_Enable, S, B);
  
  always @(mode, Op_code, S_in) begin
    Exe_Cmd = 4'b0000;
    mem_read = 1'b0;
    mem_write = 1'b0;
    WB_Enable = 1'b0;
    S = 1'b0;
    B = 1'b0;
    
    case (mode)
      2'b00: begin  
        case (Op_code)
          4'b1101: begin  
            Exe_Cmd = 4'b0001;
            WB_Enable = 1'b1;
            S = S_in;
          end
          4'b1111: begin 
            Exe_Cmd = 4'b1001;
            WB_Enable = 1'b1;
            S = S_in;
          end
          4'b0100: begin  
            Exe_Cmd = 4'b0010;
            WB_Enable = 1'b1;
            S = S_in;
          end
          4'b0101: begin  
            Exe_Cmd = 4'b0011;
            WB_Enable = 1'b1;
            S = S_in;
          end
          4'b0010: begin  
            Exe_Cmd = 4'b0100;
            WB_Enable = 1'b1;
            S = S_in;
          end
          4'b0110: begin  
            Exe_Cmd = 4'b0101;
            WB_Enable = 1'b1;
            S = S_in;
          end
          4'b0000: begin 
            Exe_Cmd = 4'b0110;
            WB_Enable = 1'b1;
            S = S_in;
          end
          4'b1100: begin  
            Exe_Cmd = 4'b0111;
            WB_Enable = 1'b1;
            S = S_in;
          end
          4'b0001: begin  
            Exe_Cmd = 4'b1000;
            WB_Enable = 1'b1;
            S = S_in;
          end
          4'b1010: begin  
            Exe_Cmd = 4'b0100;
            // WB_Enable = 1'b0;
            S = 1'b1;
          end
          4'b1000: begin 
            Exe_Cmd = 4'b0110;
            //WB_Enable = 1'b0;
            S = 1'b1;
          end
          default: begin
          end
        endcase
      end

      2'b01: begin  
        case (S_in)
          1'b1: begin 
            Exe_Cmd = 4'b0010;
            mem_read = 1'b1;
            WB_Enable = 1'b1;
            // S = 1'b1;
          end
          1'b0: begin 
            Exe_Cmd = 4'b0010;
            mem_write = 1'b1;
            // WB_Enable = 1'b0;
            // S = 1'b0;
          end
          default: begin
          end
        endcase
      end

      2'b10: begin 
        Exe_Cmd = 4'bxxxx;
        S = S_in;
        B = 1'b1;
      end
      default: begin
      end
    endcase
  end

endmodule
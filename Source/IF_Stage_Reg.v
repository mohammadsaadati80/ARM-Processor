module IF_Stage_Reg (
    input clk, rst, freeze, flush,
    input [31:0]PC_in, Instruction_in,
    output reg [31:0]PC, Instruction
);
    
    always @ (posedge clk, posedge rst) begin
    if (rst) begin
      PC <= 32'b00000000000000000000000000000000;
      Instruction <= 32'b11100000000000000000000000000000;
    end else if (!freeze) begin
      if (flush) begin
        PC <= 32'b00000000000000000000000000000000;
        Instruction <= 32'b11100000000000000000000000000000;
      end else begin
        PC <= PC_in;
        Instruction <= Instruction_in;
      end
    end
  end

endmodule
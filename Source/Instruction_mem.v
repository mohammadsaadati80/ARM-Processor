module Instruction_mem (
    input clk, rst,
    input [31:0]PC,
    output reg [31:0]Instruction
);

    reg [7:0] _Instruction[0:27];
  
    always @ (*) begin
        if (rst) begin
            {_Instruction[0],  _Instruction[1],  _Instruction[2],  _Instruction[3]} =  32'b000000_00001_00010_00000_00000000000;
            {_Instruction[4],  _Instruction[5],  _Instruction[6],  _Instruction[7]} =  32'b000000_00011_00100_00000_00000000000;
            {_Instruction[8],  _Instruction[9],  _Instruction[10], _Instruction[11]} = 32'b000000_00101_00110_00000_00000000000;
            {_Instruction[12], _Instruction[13], _Instruction[14], _Instruction[15]} = 32'b000000_00111_01000_00010_00000000000;
            {_Instruction[16], _Instruction[17], _Instruction[18], _Instruction[19]} = 32'b000000_01001_01010_00011_00000000000;
            {_Instruction[20], _Instruction[21], _Instruction[22], _Instruction[23]} = 32'b000000_01011_01100_00000_00000000000;
            {_Instruction[24], _Instruction[25], _Instruction[26], _Instruction[27]} = 32'b000000_01101_01110_00000_00000000000;
        end else 
            Instruction <= {_Instruction[PC + 2'b00], _Instruction[PC + 2'b01], _Instruction[PC + 2'b10], _Instruction[PC + 2'b11]};  
  end
    
endmodule
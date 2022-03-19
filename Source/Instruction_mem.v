module Instruction_mem (
    input clk, rst,
    input [31:0]PC,
    output reg [31:0]Instruction
);

    reg [16:0] _Instruction[0:31];
  
    always @ (*) begin
        if (rst) begin
            {_Instruction[3],  _Instruction[2],  _Instruction[1],  _Instruction[0]} =  32'b000000_00001_00010_00000_00000000000;
            {_Instruction[7],  _Instruction[6],  _Instruction[5],  _Instruction[4]} =  32'b000000_00011_00100_00000_00000000000;
            {_Instruction[11],  _Instruction[10],  _Instruction[9], _Instruction[8]} = 32'b000000_00101_00110_00000_00000000000;
            {_Instruction[15], _Instruction[14], _Instruction[13], _Instruction[12]} = 32'b000000_00111_01000_00010_00000000000;
            {_Instruction[19], _Instruction[18], _Instruction[17], _Instruction[16]} = 32'b000000_01001_01010_00011_00000000000;
            {_Instruction[23], _Instruction[22], _Instruction[21], _Instruction[20]} = 32'b000000_01011_01100_00000_00000000000;
            {_Instruction[27], _Instruction[26], _Instruction[25], _Instruction[24]} = 32'b000000_01101_01110_00000_00000000000;
            {_Instruction[31], _Instruction[30], _Instruction[29], _Instruction[28]} = 32'b000000_01101_01110_00000_00000000000;
            {_Instruction[35], _Instruction[34], _Instruction[33], _Instruction[32]} = 32'b000000_01101_01110_00000_00000000000;
            {_Instruction[39], _Instruction[38], _Instruction[37], _Instruction[36]} = 32'b000000_01101_01110_00000_00000000000;
            {_Instruction[43], _Instruction[42], _Instruction[41], _Instruction[40]} = 32'b000000_01101_01110_00000_00000000000;
            {_Instruction[47], _Instruction[46], _Instruction[45], _Instruction[44]} = 32'b000000_01101_01110_00000_00000000000;
            {_Instruction[51], _Instruction[50], _Instruction[49], _Instruction[48]} = 32'b000000_01101_01110_00000_00000000000;
            {_Instruction[55], _Instruction[54], _Instruction[53], _Instruction[52]} = 32'b000000_01101_01110_00000_00000000000;
            {_Instruction[59], _Instruction[58], _Instruction[57], _Instruction[56]} = 32'b000000_01101_01110_00000_00000000000;
            {_Instruction[63], _Instruction[62], _Instruction[61], _Instruction[60]} = 32'b000000_01101_01110_00000_00000000000;
            {_Instruction[67], _Instruction[66], _Instruction[65], _Instruction[64]} = 32'b000000_01101_01110_00000_00000000000;
        end else 
            Instruction <= {_Instruction[PC + 2'b11], _Instruction[PC + 2'b10], _Instruction[PC + 2'b01], _Instruction[PC + 2'b00]};  
  end
    
endmodule
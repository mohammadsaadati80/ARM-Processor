module Instruction_mem (
    input clk, rst,
    input [31:0]PC,
    output reg [31:0]Instruction
);

    reg [7:0] _Instruction[71:0];
  
    always @ (*) begin
        if (rst) begin
            {_Instruction[3],  _Instruction[2],  _Instruction[1],  _Instruction[0]} =  32'b1110_00_1_1101_0_0000_0000_000000010100;
            {_Instruction[7],  _Instruction[6],  _Instruction[5],  _Instruction[4]} =  32'b1110_00_1_1101_0_0000_0001_101000000001;
            {_Instruction[11],  _Instruction[10],  _Instruction[9], _Instruction[8]} = 32'b1110_00_1_1101_0_0000_0010_000100000011;
            {_Instruction[15], _Instruction[14], _Instruction[13], _Instruction[12]} = 32'b1110_00_0_0100_1_0010_0011_000000000010;
            {_Instruction[19], _Instruction[18], _Instruction[17], _Instruction[16]} = 32'b1110_00_0_0101_0_0000_0100_000000000000;
            {_Instruction[23], _Instruction[22], _Instruction[21], _Instruction[20]} = 32'b1110_00_0_0010_0_0100_0101_000100000100;
            {_Instruction[27], _Instruction[26], _Instruction[25], _Instruction[24]} = 32'b1110_00_0_0110_0_0000_0110_000010100000;
            {_Instruction[31], _Instruction[30], _Instruction[29], _Instruction[28]} = 32'b1110_00_0_1100_0_0101_0111_000101000010;
            {_Instruction[35], _Instruction[34], _Instruction[33], _Instruction[32]} = 32'b1110_00_0_0000_0_0111_1000_000000000011;
            {_Instruction[39], _Instruction[38], _Instruction[37], _Instruction[36]} = 32'b1110_00_0_1111_0_0000_1001_000000000110;
            {_Instruction[43], _Instruction[42], _Instruction[41], _Instruction[40]} = 32'b1110_00_0_0001_0_0100_1010_000000000101;
            {_Instruction[47], _Instruction[46], _Instruction[45], _Instruction[44]} = 32'b1110_00_0_1010_1_1000_0000_000000000110;
            {_Instruction[51], _Instruction[50], _Instruction[49], _Instruction[48]} = 32'b0001_00_0_0100_0_0001_0001_000000000001;
            {_Instruction[55], _Instruction[54], _Instruction[53], _Instruction[52]} = 32'b1110_00_0_1000_1_1001_0000_000000001000;
            {_Instruction[59], _Instruction[58], _Instruction[57], _Instruction[56]} = 32'b0000_00_0_0100_0_0010_0010_000000000010;
            {_Instruction[63], _Instruction[62], _Instruction[61], _Instruction[60]} = 32'b1110_00_1_1101_0_0000_0000_101100000001;
            {_Instruction[67], _Instruction[66], _Instruction[65], _Instruction[64]} = 32'b1110_01_0_0100_0_0000_0001_000000000000;
            {_Instruction[71], _Instruction[70], _Instruction[69], _Instruction[68]} = 32'b1110_01_0_0100_1_0000_1011_000000000000;
        end else 
            Instruction <= {_Instruction[PC + 2'b11], _Instruction[PC + 2'b10], _Instruction[PC + 2'b01], _Instruction[PC + 2'b00]};  
  end
    
endmodule
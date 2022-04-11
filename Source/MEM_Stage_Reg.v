module MEM_Stage_Reg (
    input clk, rst,
    input [31:0]PC_in,
    output reg [31:0]PC
);

    //TODO Need to be completed

    always @ (posedge clk, posedge rst) 
        if (rst)
            PC <= 32'b00000000000000000000000000000000;
        else
            PC <= PC_in;
    
endmodule
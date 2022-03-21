module RegisterFile (
	input clk, rst, 
    input [3:0] src1, src2, Dest_wb,
	input[31:0] Result_wb,
    input writeBackEn,
	output [31:0] reg1,reg2
);
    
    reg[31:0] registers[0:14];
    integer i = 0;

    always @(negedge clk, posedge rst) begin
		if (rst) begin
            for (i = 0 ; i < 15 ; i = i + 1)
                registers[i] <= i;
        end
        else if (writeBackEn) //todo might need to be if
            registers[Dest_wb] <= Result_wb;
	end

    assign reg1 = registers[src1];
    assign reg2 = registers[src2];

endmodule
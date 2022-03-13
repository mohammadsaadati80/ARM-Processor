`timescale 1ps/1ps

module Pipe_Line_Test_Bench ();

    integer i;
    reg clk, rst;
 
    ARM test(clk, rst);

    initial begin
        rst = 1'b0;
        #35 rst = 1'b1;
        #35 rst = 1'b0;
        for (i = 0; i < 10; i=i+1) begin
            #100 clk = 1'b0;
            #100 clk = 1'b1;
        end
    end

    // reg clk = 1'b0, rst = 1'b0;

	// ARM ARM(.clk(clk), .rst(rst));

	// initial repeat(100) #100 clk = ~clk;

	// initial begin
	// 	#250
	// 	rst = 1'b1;
	// 	#100
	// 	rst = 1'b0;
	// end
    
endmodule

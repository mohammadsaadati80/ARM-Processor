`timescale 1ps/1ps

module Pipe_Line_Test_Bench ();

    reg clk = 1, rst = 1;
 
    ARM test(clk, rst, 0);

    always #10 clk = ~clk;

    initial begin
        #10 rst = 0;
        #10000 $stop;
    end

endmodule

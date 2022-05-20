`timescale 1ps/1ps

module Test_Bench ();

    reg clk = 1, rst = 1;
 
    wire sram_we_n;
    wire [31:0] sram_dq;
    wire [16:0] sram_address;

    SRAM sram(clk, rst, sram_we_n, sram_address, sram_dq);
    ARM test(clk, rst, 0, sram_dq, sram_we_n, sram_address);

    always #10 clk = ~clk;

    initial begin
        #10 rst = 0;
        #5000 $stop;
    end

endmodule

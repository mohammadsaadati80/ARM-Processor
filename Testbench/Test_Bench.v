`timescale 1ps/1ps

module Test_Bench ();

    reg clk = 1, rst = 1;
 
    wire SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N;
    wire [15:0] sram_dq;
    wire [17:0] sram_address;

    SRAM sram(clk, rst, SRAM_WE_N, sram_address, sram_dq);
    ARM test(clk, rst, 1'b0, sram_dq, sram_address, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N);

    always #10 clk = ~clk;

    initial begin
        #10 rst = 0;
        #10000 $stop;
    end

endmodule

module WB_Stage (input clk, rst, mem_r_en, wb_wb_en_in
    input [31:0]alu_result, mem_result, input [3:0]   wb_dest_in,
    output [3:0]  wb_dest, output [31:0] wb_value, output wb_wb_en);

    assign wb_dest = wb_dest_in;
    assign wb_wb_en = wb_wb_en_in;
    assign wb_value = mem_r_en ? mem_result : alu_result;

endmodule
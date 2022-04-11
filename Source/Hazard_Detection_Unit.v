module Hazard_Detection_Unit (input clk, rst, exe_wb_en, mem_wb_en, two_src,
    input [3:0]src_1, src_2, exe_dest, mem_dest,
    output reg hazard_detected);
  
    always @ (*) begin
        hazard_detected = 1'b0;
        if (mem_wb_en && (src_1 == mem_dest))
            hazard_detected = 1'b1;
        if (exe_wb_en && two_src && (src_2 == exe_dest))
            hazard_detected = 1'b1;
        if (exe_wb_en && (src_1 == exe_dest))
            hazard_detected = 1'b1;
        if (mem_wb_en && two_src && (src_2 == mem_dest))
            hazard_detected = 1'b1;
    end
endmodule

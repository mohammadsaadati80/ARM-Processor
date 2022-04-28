module HazardDetectionUnit (input clk, rst, input [3:0]src_1, src_2, exe_dest, input exe_wb_en,
  input [3:0]mem_dest, input mem_wb_en, two_src, output reg hazard_detected);
  
  always @ (*) begin
    hazard_detected = 1'b0;
    if (exe_wb_en && (src_1 == exe_dest)) hazard_detected = 1'b1;
    if (exe_wb_en && two_src && (src_2 == exe_dest)) hazard_detected = 1'b1;
    if (mem_wb_en && (src_1 == mem_dest)) hazard_detected = 1'b1;
    if (mem_wb_en && two_src && (src_2 == mem_dest)) hazard_detected = 1'b1;
  end

endmodule

module EXE_Stage_Reg (input clk, rst, freeze, wb_en_in, mem_r_en_in, mem_w_en_in, input [31:0]alu_result_in,
  input [3:0]dest_in, input [31:0]val_rm_in, output reg wb_en, mem_r_en, mem_w_en,
  output reg [31:0]alu_result, output reg [3:0]dest, output reg [31:0]val_rm);

  always @ (posedge clk, posedge rst) begin
    if (rst) begin      
      val_rm <= 32'b00000000000000000000000000000000;
      alu_result <= 32'b00000000000000000000000000000000;
      dest <= 4'b0000; wb_en <= 1'b0; mem_w_en <= 1'b0; mem_r_en <= 1'b0;
    end else if (!freeze) begin
      val_rm <= val_rm_in; wb_en <= wb_en_in; dest <= dest_in;
      mem_r_en <= mem_r_en_in; mem_w_en <= mem_w_en_in; alu_result <= alu_result_in;
    end
  end
  
endmodule

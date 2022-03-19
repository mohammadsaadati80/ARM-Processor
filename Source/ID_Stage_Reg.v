module ID_Stage_Reg (
    input clk, rst, wb_en_in, mem_r_en_in, mem_w_en_in, b_in, s_in, imm_in, flush,
    input [3:0]exe_cmd_in, dest_in, src_1_in, src_2_in, sr_in,
    input [11:0]shift_operand_in,
    input [23:0]imm_signed_24_in,
    input [31:0]PC_in, value_rn_in, value_rm_in,
    output reg wb_en, mem_r_en, mem_w_en, b, s, imm,
    output reg [3:0]exe_cmd, value_rn, value_rm, dest, sr, src_1, src_2,
    output reg [11:0]shift_operand,
    output reg [23:0]imm_signed_24,
    output reg [31:0]PC
);

    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            wb_en <= 1'b0;
            mem_r_en <= 1'b0;
            mem_w_en <= 1'b0;
            exe_cmd <= 4'b0000;
            b <= 1'b0;
            s <= 1'b0;
            PC <= 32'b00000000000000000000000000000000;
            value_rn <= 32'b00000000000000000000000000000000;
            value_rm <= 32'b00000000000000000000000000000000;
            shift_operand <= 12'b000000000000;
            imm <= 1'b0;
            imm_signed_24 <= 24'b000000000000000000000000;
            dest <= 4'b0000;
            sr <= 4'b0000;
        end else begin
            if (flush) begin
                wb_en <= 1'b0;
                mem_r_en <= 1'b0;
                mem_w_en <= 1'b0;
                exe_cmd <= 4'b0000;
                b <= 1'b0;
                s <= 1'b0;
                PC <= 32'b00000000000000000000000000000000;
                value_rn <= 32'b00000000000000000000000000000000;
                value_rm <= 32'b00000000000000000000000000000000;
                shift_operand <= 12'b000000000000;
                imm <= 1'b0;
                imm_signed_24 <= 24'b000000000000000000000000;
                dest <= 4'b0000;
                sr <= 4'b0000;
                src_1 <= 4'b0000;
                src_2 <= 4'b0000;
            end else begin
                wb_en <= wb_en_in;
                mem_r_en <= mem_r_en_in;
                mem_w_en <= mem_w_en_in;
                exe_cmd <= exe_cmd_in;
                b <= b_in;
                s <= s_in;
                PC <= PC_in;
                value_rn <= value_rn_in;
                value_rm <= value_rm_in;
                shift_operand <= shift_operand_in;
                imm <= imm_in;
                imm_signed_24 <= imm_signed_24_in;
                dest <= dest_in;
                sr <= sr_in;  
                src_1 <= src_1_in;
                src_2 <= src_2_in;
            end
        end
  end
    
endmodule
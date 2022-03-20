module ID_Stage (
    input clk, rst, hazard, wb_wb_en,
    input [3:0]sr, wb_dest,
    input [31:0]PC_in, instruction, wb_value,
    output wb_en, mem_r_en, mem_w_en, b, s, imm, two_src,
    output [3:0]exe_cmd, dest, src_1, src_2,
    output [11:0]shift_operand,
    output [23:0]imm_signed_24,
    output [31:0]PC, value_rn, value_rm
);

    wire [1:0] mode;
    wire [3:0] rn, rm, rd, op_code, cond, exe_cmd_ouput, register_file_src_2;
    wire or_output, mem_r_en_output, mem_w_en_output, wb_en_output, s_output, b_output, condition_check_result, s_in;

    assign PC = PC_in;

    assign rm = instruction[3:0];
    assign rd = instruction[15:12];
    assign rn = instruction[19:16];

    assign register_file_src_2 = mem_w_en ? rd : rm;

    assign cond = instruction[31:28];
    assign or_output = (hazard || (~condition_check_result));

    assign {exe_cmd, mem_r_en, mem_w_en, wb_en, s, b} = or_output ? 9'b000000000
                            : {exe_cmd_ouput, mem_r_en_output, mem_w_en_output, wb_en_output, s_output, b_output};

    assign mode = instruction[27:26];
    assign op_code = instruction[24:21];
    assign s_in = instruction[20];

    assign shift_operand = instruction[11:0];
    assign imm = instruction[25];
    assign imm_signed_24 = instruction[23:0];
    assign dest = instruction[15:12];

    assign two_src = ((~instruction[25]) || mem_w_en);

    assign src_1 = rn;
    assign src_2 = register_file_src_2;

    Condition_Check condition_check(cond, sr, condition_check_result);

    RegisterFile register_file(.clk(clk),.rst(rst),.src1(src_1),.src2(src_2),.Dest_wb(wb_dest),.Result_wb(wb_value),.writeBackEn(wb_wb_en),.reg1(value_rn),.reg2(value_rm));

    // RegisterFile register_file(clk, rst, rn, register_file_src_2, wb_dest, wb_value, wb_wb_en, value_rn, value_rm);
    ControlUnit control_unit(mode, op_code, s_in, exe_cmd_ouput, mem_r_en_output, mem_w_en_output, wb_en_output, s_output, b_output);

endmodule
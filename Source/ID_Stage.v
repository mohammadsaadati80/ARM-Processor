module ID_Stage (input clk, rst, input [31:0]pc_in, instruction,
  input hazard, input [3:0]sr, wb_dest, input [31:0]wb_value,
  input wb_wb_en, output wb_en, mem_r_en, mem_w_en, output [3:0]exe_cmd, output b, s,
  output [31:0] pc, output [31:0] value_rn, value_rm,output [11:0] shift_operand, output imm,
  output [23:0]imm_signed_24, output [3:0]dest, output two_src, output [3:0]src_1, src_2);
  
  wire condition_check_result, or_output, s_in;
  wire mem_r_en_output, mem_w_en_output, wb_en_output, s_output, b_output;

  wire [1:0] mode;

  wire [3:0]rn, rm, rd, register_file_src_2, cond, exe_cmd_ouput, op_code;

  assign rm = instruction[3:0];
  assign rd = instruction[15:12];
  assign rn = instruction[19:16];

  assign src_1 = rn;
  assign src_2 = register_file_src_2;
  
  assign s_in = instruction[20];
  assign mode = instruction[27:26];
  assign op_code = instruction[24:21];
  
  assign pc = pc_in;
  assign imm = instruction[25];
  assign dest = instruction[15:12];
  assign shift_operand = instruction[11:0];
  assign imm_signed_24 = instruction[23:0];

  assign cond = instruction[31:28];
  assign register_file_src_2 = mem_w_en ? rd : rm;
  assign or_output = (hazard || (~condition_check_result));
  assign {exe_cmd, mem_r_en, mem_w_en, wb_en, s, b} = or_output ? 9'b000000000 :
         {exe_cmd_ouput, mem_r_en_output, mem_w_en_output, wb_en_output, s_output, b_output};

  assign two_src = ((~instruction[25]) || mem_w_en);

  Condition_Check condition_check(cond, sr, condition_check_result);
  RegisterFile register_file(clk, rst, rn, register_file_src_2, wb_dest, wb_value, wb_wb_en, value_rn, value_rm);
  ControlUnit control_unit(mode, op_code, s_in, exe_cmd_ouput, mem_r_en_output, mem_w_en_output, wb_en_output, s_output,
                           b_output);

endmodule

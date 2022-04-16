module ARM (input clk,rst);

	wire hazard, wb_wb_en, wb_en_id, mem_r_en_id, mem_w_en_id, b_id, s_id, imm_id;
	wire two_src_id, wb_en_id_reg, mem_r_en_id_reg, mem_w_en_id_reg, b_id_reg, s_id_reg, imm_id_reg;
	wire wb_en_exe, mem_r_en_exe, mem_w_en_exe, wb_en_exe_reg, mem_r_en_exe_reg, mem_w_en_exe_reg, wb_en_mem, mem_r_en_mem; 
	wire mem_w_en_mem, wb_en_mem_reg, mem_r_en_mem_reg;
	wire [3:0]sr, wb_dest, exe_cmd_id, dest_id, src_1_id, src_2_id, exe_cmd_id_reg, dest_id_reg;
	wire [3:0] dest_mem_reg, sr_id_reg, status_exe, dest_exe, dest_exe_reg, dest_mem;
	wire [11:0]shift_operand_id, shift_operand_id_reg;
	wire [23:0]imm_signed_24_id, imm_signed_24_id_reg;
	wire [31:0]pc, instruction, pc_if_reg, instruction_if_reg, wb_value, pc_id, value_rn_id, value_rm_id;
	wire [31:0]pc_id_reg, value_rn_id_reg, value_rm_id_reg;
	wire [31:0] alu_result_exe, br_addr_exe, val_rm_exe, alu_result_exe_reg, val_rm_exe_reg, alu_result_mem;
	wire [31:0] data_memory_mem, alu_result_mem_reg, data_memory_out_mem_reg;

	IF_Stage if_stage(.clk(clk),.rst(rst),.freeze(hazard),.Branch_taken(b_id_reg),.BranchAddr(br_addr_exe),.PC(pc),.Instruction(instruction));
	IF_Stage_Reg if_stage_reg(.clk(clk),.rst(rst),.freeze(hazard),.flush(b_id_reg),.PC_in(pc),. Instruction_in(instruction),.PC(pc_if_reg),
								.Instruction(instruction_if_reg));

	Hazard_Detection_Unit hazard_detection_unit (.clk(clk),.rst(rst), .exe_wb_en(wb_en_exe), .mem_wb_en(wb_en_mem), .two_src(two_src_id),
												.src_1(src_1_id), .src_2(src_2_id), .exe_dest(dest_exe), .mem_dest(dest_mem), 
												.hazard_detected(hazard));

	ID_Stage id_stage(.clk(clk),.rst(rst),.hazard(hazard),.wb_wb_en(wb_wb_en),.sr(sr),.wb_dest(wb_dest),.PC_in(pc_if_reg),
					  .instruction(instruction_if_reg),.wb_value(wb_value),.wb_en(wb_en_id),.mem_r_en(mem_r_en_id),.mem_w_en(mem_w_en_id),
					  .b(b_id),.s(s_id),.imm(imm_id),.two_src(two_src_id),.exe_cmd(exe_cmd_id),.dest(dest_id),.src_1(src_1_id),.src_2(src_2_id),
					  .shift_operand(shift_operand_id),
					  .imm_signed_24(imm_signed_24_id),.PC(pc_id),.value_rn(value_rn_id),.value_rm(value_rm_id));
	ID_Stage_Reg id_stage_reg(.clk(clk),.rst(rst),.wb_en_in(wb_en_id),.mem_r_en_in(mem_r_en_id),
							  .mem_w_en_in(mem_w_en_id),.b_in(b_id),.s_in(s_id),.imm_in(imm_id),.flush(b_id_reg),
							  .exe_cmd_in(exe_cmd_id),.dest_in(dest_id),.sr_in(sr),
							  .shift_operand_in(shift_operand_id),.imm_signed_24_in(imm_signed_24_id),.PC_in(pc_id),.value_rn_in(value_rn_id),
							  .value_rm_in(value_rm_id),.wb_en(wb_en_id_reg),.mem_r_en(mem_r_en_id_reg),.mem_w_en(mem_w_en_id_reg),.b(b_id_reg),
							  .s(s_id_reg),.imm(imm_id_reg),
							  .exe_cmd(exe_cmd_id_reg),.value_rn(value_rn_id_reg),.value_rm(value_rm_id_reg),.dest(dest_id_reg),.sr(sr_id_reg),
							  .shift_operand(shift_operand_id_reg),.imm_signed_24(imm_signed_24_id_reg),.PC(pc_id_reg));

	EXE_Stage exe_stage(.clk(clk),.rst(rst), .exe_cmd(exe_cmd_id_reg), .wb_en_in(wb_en_id_reg), .mem_r_en_in(mem_r_en_id_reg), 
						.mem_w_en_in(mem_w_en_id_reg),
    					.PC_in(pc_id_reg), .val_rn(value_rn_id_reg), .val_rm(value_rm_id_reg), .imm(imm_id_reg),
						.shift_operand(shift_operand_id_reg), 
						.imm_signed_24(imm_signed_24_id_reg), .sr(sr_id_reg), .dest_in(dest_id_reg), .wb_en(wb_en_exe), .mem_r_en(mem_r_en_exe), 
						.mem_w_en(mem_w_en_exe), 
						.alu_result(alu_result_exe), .br_addr(br_addr_exe), .status(status_exe), .val_rm_out(val_rm_exe), .dest(dest_exe));

	EXE_Stage_Reg exe_stage_reg(.clk(clk),.rst(rst), .wb_en_in(wb_en_exe), .mem_r_en_in(mem_r_en_exe), .mem_w_en_in(mem_w_en_exe), 
								.alu_result_in(alu_result_exe),
    							.dest_in(dest_exe), .st_val_in(val_rm_exe), .wb_en(wb_en_exe_reg), .mem_r_en(mem_r_en_exe_reg), 
								.mem_w_en(mem_w_en_exe_reg), 
								.alu_result(alu_result_exe_reg), .dest(dest_exe_reg), .st_val(val_rm_exe_reg));

	MEM_Stage mem_stage(.clk(clk),.rst(rst), .wb_en_in(wb_en_exe_reg), .mem_r_en_in(mem_r_en_exe_reg), .mem_w_en_in(mem_w_en_exe_reg), 
						.alu_result(alu_result_exe_reg),
    					.rm_val(val_rm_exe_reg), .dest_in(dest_exe_reg), .wb_en(wb_en_mem), .mem_r_en(mem_r_en_mem), .mem_w_en(mem_w_en_mem), 
						.alu_result_out(alu_result_mem), 
						.data_memory_out(data_memory_mem), .dest(dest_mem));
	MEM_Stage_Reg mem_stage_reg(.clk(clk),.rst(rst), .wb_en_in(wb_en_mem), .mem_r_en_in(mem_r_en_mem), .alu_result_in(alu_result_mem), 
								.data_memory_out_in(data_memory_mem), 
								.dest_in(dest_mem), .wb_en(wb_en_mem_reg), .mem_r_en(mem_r_en_mem_reg), .alu_result(alu_result_mem_reg), 
								.data_memory_out(data_memory_out_mem_reg), 
								.dest(dest_mem_reg));

	Status_Register status_register (.clk(clk),.rst(rst), .s(s_id_reg), .status_bits(status_exe), .sr(sr));

	WB_Stage wb_stage(.clk(clk),.rst(rst), .alu_result(alu_result_mem_reg), .mem_result(data_memory_out_mem_reg), .mem_r_en(mem_r_en_mem_reg), 
						.wb_dest_in(dest_mem_reg), 
	.wb_wb_en_in(wb_en_mem_reg), .wb_dest(wb_dest), .wb_value(wb_value), .wb_wb_en(wb_wb_en));

	wire [31:0] mem_result;
  	assign mem_result = 32'b00000000000000000000000000000000;

endmodule
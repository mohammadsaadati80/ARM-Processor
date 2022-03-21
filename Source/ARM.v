module ARM (input clk,rst);

	wire freeze, branch_tacken, flush, hazard, wb_wb_en, wb_en_id, mem_r_en_id, mem_w_en_id, b_id, s_id, imm_id;
	wire two_src_id, wb_en_id_reg, mem_r_en_id_reg, mem_w_en_id_reg, b_id_reg, s_id_reg, imm_id_reg;
	wire [3:0]sr, wb_dest, exe_cmd_id, dest_id, src_1_id, src_2_id, exe_cmd_id_reg, dest_id_reg;
	wire [11:0]shift_operand_id, shift_operand_id_reg;
	wire [23:0]imm_signed_24_id, imm_signed_24_id_reg;
	wire [31:0]pc, branch_address, instruction, pc_if_reg, instruction_if_reg, wb_value, pc_id, value_rn_id, value_rm_id;
	wire [31:0]pc_id_reg, value_rn_id_reg, value_rm_id_reg, pc_exe, pc_exe_reg, pc_mem, pc_mem_reg, pc_wb;
  

	IF_Stage if_stage(.clk(clk),.rst(rst),.freeze(freeze),.Branch_taken(branch_tacken),.BranchAddr(branch_address),.PC(pc),.Instruction(instruction));
	IF_Stage_Reg if_stage_reg(.clk(clk),.rst(rst),.freeze(freeze),.flush(flush),.PC_in(pc),. Instruction_in(instruction),.PC(pc_if_reg),.Instruction(instruction_if_reg));

	ID_Stage id_stage(.clk(clk),.rst(rst),.hazard(hazard),.wb_wb_en(wb_wb_en),.sr(sr),.wb_dest(wb_dest),.PC_in(pc_if_reg),
					  .instruction(instruction_if_reg),.wb_value(wb_value),.wb_en(wb_en_id),.mem_r_en(mem_r_en_id),.mem_w_en(mem_w_en_id),
					  .b(b_id),.s(s_id),.imm(imm_id),.two_src(two_src_id),.exe_cmd(exe_cmd_id),.dest(dest_id),.src_1(src_1_id),.src_2(src_2_id),.shift_operand(shift_operand_id),
					  .imm_signed_24(imm_signed_24_id),.PC(pc_id),.value_rn(value_rn_id),.value_rm(value_rm_id));
	ID_Stage_Reg id_stage_reg(.clk(clk),.rst(rst),.wb_en_in(wb_en_id),.mem_r_en_in(mem_r_en_id),
							  .mem_w_en_in(mem_w_en_id),.b_in(b_id),.s_in(s_id),.imm_in(imm_id),.flush(flush),
							  .exe_cmd_in(exe_cmd_id),.dest_in(dest_id),.src_1_in(),.src_2_in(),.sr_in(),
							  .shift_operand_in(shift_operand_id),.imm_signed_24_in(imm_signed_24_id),.PC_in(pc_id),.value_rn_in(value_rn_id),
							  .value_rm_in(value_rm_id),.wb_en(wb_en_id_reg),.mem_r_en(mem_r_en_id_reg),.mem_w_en(mem_w_en_id_reg),.b(b_id_reg),.s(s_id_reg),.imm(imm_id_reg),
							  .exe_cmd(exe_cmd_id_reg),.value_rn(value_rn_id_reg),.value_rm(value_rm_id_reg),.dest(dest_id_reg),.sr(sr),.src_1(),.src_2(),
							  .shift_operand(shift_operand_id_reg),.imm_signed_24(imm_signed_24_id_reg),.PC(pc_id_reg));

	EXE_Stage exe_stage(.clk(clk),.rst(rst),.PC_in(pc_id_reg),.PC(pc_exe));
	EXE_Stage_Reg exe_stage_reg(.clk(clk),.rst(rst),.PC_in(pc_exe),.PC(pc_exe_reg));

	MEM_Stage mem_stage(.clk(clk),.rst(rst),.PC_in(pc_exe_reg),.PC(pc_mem));
	MEM_Stage_Reg mem_stage_reg(.clk(clk),.rst(rst),.PC_in(pc_mem),.PC(pc_mem_reg));

	WB_Stage wb_stage(.clk(clk),.rst(rst),.PC_in(pc_mem_reg),.PC(pc_wb));

	// IF_Stage if_stage (clk, rst, branch_tacken, branch_address, freeze, pc, instruction);
	// IF_Stage_Reg if_stage_reg (clk, rst, pc, instruction, flush, freeze, pc_if_reg, instruction_if_reg);
  
	/* ID_Stage id_stage (clk, rst, pc_if_reg, instruction_if_reg, hazard, sr, wb_dest, wb_value, wb_wb_en, wb_en_id,
		mem_r_en_id, mem_w_en_id, 13 exe_cmd_id, b_id, s_id, pc_id, value_rn_id, value_rm_id, shift_operand_id,
		imm_id, imm_signed_24_id, dest_id, two_src_id, src_1_id, src_2_id); */
  
	/* ID_Stage_Reg id_stage_reg (clk, rst, wb_en_id, mem_r_en_id, mem_w_en_id, exe_cmd_id, b_id, s_id, pc_id,
		value_rn_id, value_rm_id, shift_operand_id, imm_id, imm_signed_24_id, dest_id, flush,
		wb_en_id_reg, 18 mem_r_en_id_reg, mem_w_en_id_reg, exe_cmd_id_reg, b_id_reg, s_id_reg, pc_id_reg,
		value_rn_id_reg, value_rm_id_reg, shift_operand_id_reg, imm_id_reg, imm_signed_24_id_reg, dest_id_reg); */
  
	// EXE_Stage exe_stage (clk, rst, pc_id_reg, pc_exe);
	// EXE_Stage_Reg exe_stage_reg (clk, rst, pc_exe, pc_exe_reg);

	// MEM_Stage mem_stage (clk, rst, pc_exe_reg, pc_mem);
	// MEM_Stage_Reg mem_stage_reg (clk, rst, pc_mem, pc_mem_reg);
	
	// WB_Stage wb_stage (clk, rst, pc_mem_reg, pc_wb);

	assign branch_tacken = 1'b0;
	assign branch_address = 32'b00000000000000000000000000000000;
	assign freeze = 1'b0;

	assign flush = 1'b0;

	assign hazard = 1'b0;
	assign sr = 4'b0000;
	assign wb_dest = 4'b0000;
	assign wb_value = 32'b00000000000000000000000000000000;
	assign wb_wb_en = 1'b0;

endmodule
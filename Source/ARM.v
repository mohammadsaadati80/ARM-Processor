module ARM (
    input clk,
    input rst
  );

    wire Branch_taken, flush, freeze;
    wire [31:0] BranchAddr;
    wire [31:0] Instruction_IF;
    wire [31:0] Instruction_IF_Reg;
    wire [31:0] PC_EXE;
    wire [31:0] PC_EXE_Reg;
    wire [31:0] PC_ID;
    wire [31:0] PC_ID_Reg;
    wire [31:0] PC_IF;
    wire [31:0] PC_IF_Reg;
    wire [31:0] PC_MEM;
    wire [31:0] PC_MEM_Reg;
    wire [31:0] PC_WB;
  
    assign BranchAddr = 32'b00000000000000000000000000000000;
    assign Branch_taken = 1'b0;
    assign flush = 1'b0;
    assign freeze = 1'b0;
  

    IF_Stage _if_stage_ (.clk(clk), .rst(rst), .freeze(freeze), .Branch_taken(Branch_taken),
		                .BranchAddr(BranchAddr), .PC(PC_IF), .Instruction(Instruction_IF) );
    IF_Stage_Reg _if_stage_reg_ (.clk(clk), .rst(rst), .freeze(freeze), .flush(flush), .PC_in(PC_IF), 
                            .Instruction_in(Instruction_IF), .PC(PC_IF_Reg), .Instruction(Instruction_IF_Reg));

    ID_Stage _id_stage_ (.clk(clk), .rst(rst), .PC_in(PC_IF_Reg), .PC(PC_ID));
    ID_Stage_Reg _id_stage_reg_ (.clk(clk), .rst(rst), .PC_in(PC_ID), .PC(PC_ID_Reg));

    EXE_Stage _exe_stage_ (.clk(clk), .rst(rst), .PC_in(PC_ID_Reg), .PC(PC_EXE));
    EXE_Stage_Reg _exe_stage_reg_ (.clk(clk), .rst(rst), .PC_in(PC_EXE), .PC(PC_EXE_Reg));

    MEM_Stage _mem_stage_ (.clk(clk), .rst(rst), .PC_in(PC_EXE_Reg), .PC(PC_MEM));
    MEM_Stage_Reg _mem_stage_reg_ (.clk(clk), .rst(rst), .PC_in(PC_MEM), .PC(PC_MEM_Reg));

    WB_Stage _wb_stage_ (.clk(clk), .rst(rst), .PC_in(PC_MEM_Reg), .PC(PC_WB));

endmodule
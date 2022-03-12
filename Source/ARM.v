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
  
    EXE_Stage EXE_Stage (.clk(clk), .rst(rst), .PC_in(PC_ID_Reg), .PC(PC_EXE));
    EXE_Stage_Reg EXE_Stage_Reg (.clk(clk), .rst(rst), .PC_in(PC_EXE), .PC(PC_EXE_Reg));
    ID_Stage ID_Stage (.clk(clk), .rst(rst), .PC_in(PC_IF_Reg), .PC(PC_ID));
    ID_Stage_Reg ID_Stage_Reg (.clk(clk), .rst(rst), .PC_in(PC_ID), .PC(PC_ID_Reg));
    IF_Stage IF_Stage (.clk(clk), .rst(rst), .freeze(freeze), .Branch_taken(Branch_taken),
		                .BranchAddr(BranchAddr), .PC(PC_IF), .Instruction(Instruction_IF) );
    IF_Stage_Reg IF_Stage_Reg (.clk(clk), .rst(rst), .freeze(freeze), .flush(flush), .PC_in(PC_IF), 
                            .Instruction_in(Instruction_IF), .PC(PC_IF_Reg), .Instruction(Instruction_IF_Reg));
    MEM_Stage MEM_Stage (.clk(clk), .rst(rst), .PC_in(PC_EXE_Reg), .PC(PC_MEM));
    MEM_Stage_Reg MEM_Stage_Reg (.clk(clk), .rst(rst), .PC_in(PC_MEM), .PC(PC_MEM_Reg));
    WB_Stage WB_Stage (.clk(clk), .rst(rst), .PC_in(PC_MEM_Reg), .PC(PC_WB));

endmodule
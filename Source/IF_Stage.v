module IF_Stage (
    input clk, rst, freeze, Branch_taken,
    input [31:0]BranchAddr,
    output [31:0]PC, Instruction
);
    
    wire [31:0] mux;
    wire [31:0] pc_out;

    assign mux = Branch_taken ? BranchAddr : PC;

    PC pc_reg (clk, rst, mux, freeze, pc_out);

    assign PC = pc_out + 4;

    Instruction_Memory instruction_memory (clk, rst, pc_out, Instruction);

endmodule
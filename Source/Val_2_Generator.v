module Val2Generator(input clk, rst, imm, select, input [11:0]shift_operand, input [31:0]rm, output reg [31:0]val_2);

    wire [7:0] eight_immed;
    wire [3:0] rotate_imm;
    wire [1:0] shift;
    wire [4:0] shift_imm;

    assign eight_immed = shift_operand[7:0];
    assign rotate_imm = shift_operand[11:8];
    assign shift = shift_operand[6:5];
    assign shift_imm = shift_operand[11:7];
    
    always @(rm, shift_operand, imm, select) begin
        val_2 = 32'b00000000000000000000000000000000;
        case (select)
            1'b0: begin
                case (imm)
                    1'b1: begin val_2 = {{eight_immed}, {{24{1'b0}}, {eight_immed}}} >> (rotate_imm * 2); end
                    1'b0: begin
                        if (shift_operand[3] == 1'b0) begin
                            case (shift)
                                2'b00: begin val_2 = rm << shift_imm; end
                                2'b01: begin val_2 = rm >> shift_imm; end
                                2'b10: begin val_2 = rm >>> shift_imm; end
                                2'b11: begin val_2 = {{rm}, {rm}} >> shift_imm; end
                            endcase
                        end 
                        else val_2 = rm;
                    end
                endcase
            end
            1'b1: begin val_2 = {{20'b00000000000000000000}, {shift_operand}}; end
        endcase
    end
endmodule

        
`timescale 1ns / 1ps


module SingleCycleController(instruction_in, instruction_out, nop, AndValue, ALUSrc, ALUop, ALUSrc2, JumpSrc, RegDst, Branch, MemRead, 
MemWrite, Unconditional, BranchNE, MemWriteSrc, MemtoReg, RegWrite, RegWriteSrc);

    input [31:0] instruction_in;
    input nop;

    output reg [31:0] AndValue, instruction_out;
    output reg [3:0] ALUop;
    output reg [1:0] ALUSrc, RegDst, MemtoReg, JumpSrc;
    output reg ALUSrc2, Branch, MemRead, MemWrite, Unconditional, BranchNE, MemWriteSrc, RegWrite, RegWriteSrc;

    //assign  opcode = instruction_in [31:26];
    //assign special = instruction_in [5:0];
    //assign regimm = instruction_in [20:16]; //used for bgez and bltz
    
    always @ (instruction_in, nop)
     begin
    
        AndValue <= 0;
        ALUop <= 3'b0; //add
        ALUSrc <= 2'b0;
        ALUSrc2 <= 0;
        RegDst <= 0;
        MemtoReg <= 2'b0;
        JumpSrc <= 2'b0;
        Branch <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        Unconditional <= 0;
        BranchNE <= 0;
        MemWriteSrc <= 0;
        RegWrite <= 0;
        RegWriteSrc <= 0;

        
        if (nop)
            instruction_out <= 0;
        else
            instruction_out <= instruction_in;

        if(~nop) begin
            case(instruction_in[31:26])//opcode
                //SPECIAL opcode - contains multiple types operations, but relies on last 6 bits of instruction_in to determine what control signals to turn on//
                6'b000000: 
                begin
                    //default control signals that MOST operations use in this category, any overrides are in their specific cases
                    RegDst <= 2'b01;
                    MemtoReg <= 1;
                    RegWrite <= 1;
                    
                    case(instruction_in[5:0])//SPECIAL last 6 bits determine instruction_in
                        //ARITHMETIC//
                        6'b100000: 
                            begin //add the default control signals above should be sufficient to complete add instruction_in
                            RegDst <= 2'b01;
                            ALUSrc <= 2'b00;
                            end
                        6'b100010: //sub
                            begin
                            ALUop <= 4'b0010;
                            RegDst <= 2'b01;
                            end

                        //BRANCH//
                        6'b001000: //jr
                            begin
                            RegWrite <= 0;
                            JumpSrc <= 2'b01;
                            Unconditional <= 1;
                            end

                        //LOGICAL//
                        6'b100100: //and
                            begin
                            ALUop <= 4'b0100;
                            end
                        6'b100101: //or
                            begin
                            ALUop <= 4'b0101;
                            end
                        6'b100111: //nor
                            begin
                            ALUop <= 4'b0111;
                            end
                        6'b100110: //xor
                            begin
                            ALUop <= 4'b0110;
                            end
                        6'b000000: //sll
                            begin
                            ALUSrc2 <= 1'b1;
                            ALUSrc <= 2'b11;
                            ALUop <= 4'b1000;
                            end
                        6'b000010: //srl
                            begin
                            ALUSrc2 <= 1'b1;
                            ALUSrc <= 2'b11;
                            ALUop <= 4'b1001;
                            end
                        6'b101010: //slt
                            begin
                            ALUop <= 4'b1100; //slt
                            end
                        default:
                            begin
                            end
                    endcase
                end
                //ARITHMETIC//
                6'b001000: //Addi
                    begin
                    ALUSrc <= 2'b01;
                    MemtoReg <= 1;
                    RegWrite <= 1;
                    end
                6'b011100: //mul
                    begin
                    ALUop <= 4'b0011; //mul
                    RegDst <= 1;
                    MemtoReg <= 1;
                    RegWrite <= 1;
                    end
                //DATA//
                6'b100011: //lw
                    begin
                    ALUSrc <= 2'b01;
                    MemRead <= 1;
                    RegWrite <= 1;
                    end
                6'b100000: //lb
                    begin
                    ALUSrc <= 2'b01;
                    MemRead <= 1;
                    RegWrite <= 1;
                    AndValue <= 32'h000000FF;
                    RegWriteSrc <= 1;
                    end
                6'b100001: //lh
                    begin
                    ALUSrc <= 2'b01;
                    MemRead <= 1;
                    RegWrite <= 1;
                    AndValue <= 32'h0000ffff;
                    RegWriteSrc <= 1;
                    end
                6'b101011: // sw
                    begin
                    ALUSrc <= 2'b01;
                    MemWrite <= 1;
                    end
                6'b101000: //sb
                    begin
                    ALUSrc <= 2'b01;
                    MemWrite <= 1;
                    AndValue <= 8'h000000FF;
                    MemWriteSrc <= 1;
                    end
                6'b101001: //sh
                    begin
                    ALUSrc <= 2'b01;
                    MemWrite <= 1;
                    AndValue <= 32'h0000FFFF;
                    MemWriteSrc <= 1;
                    end
                //BRANCH
                6'b000001: //bgez and bltz need bits from regimm variable to differntiate because they have same opcode
                    begin //default is bgez
                    ALUSrc <= 2'b10;
                    ALUop <= 1100; //slt
                    Branch <= 1;
                    if(instruction_in[20:16] == 6'b000000)// bltz
                        begin
                        BranchNE <= 1;
                        end
                    end
                6'b000110: //blez
                    begin
                    ALUSrc <= 2'b10;
                    ALUop <= 1101; //sgt
                    Branch <= 1;
                    end
                6'b000111: //bgtz
                    begin
                    ALUSrc <= 2'b10;
                    ALUop <= 1101; //sgt
                    Branch <= 1;
                    BranchNE <= 1;
                    end
                6'b000100: //beq
                    begin
                    ALUop <= 4'b0010;
                    Branch <= 1;
                    end
                6'b000101: //bne
                    begin
                    ALUop <= 4'b0010;
                    Branch <= 1;
                    BranchNE <= 1;
                    end
                6'b000010: //jump
                    begin
                    JumpSrc <= 2'b10;
                    Unconditional <= 1;
                    end
                6'b000011: //jump and link
                    begin
                    JumpSrc <= 2'b10;
                    RegDst <= 2'b10;
                    Unconditional <= 1;
                    MemtoReg <= 2'b10;
                    RegWrite <= 1;
                    end
                //LOGICAL//
                6'b001100: //and immediate
                    begin
                    ALUSrc <= 2'b01;
                    ALUop <= 4'b0100; //and
                    MemtoReg <= 1;
                    RegWrite <= 1;
                    end
                6'b001101: //or immediate
                    begin
                    ALUSrc <= 2'b01;
                    ALUop <= 4'b0101; //or
                    MemtoReg <= 1;
                    RegWrite <= 1;
                    end
                6'b001110: //xor immediate
                    begin
                    ALUSrc <= 2'b01;
                    ALUop <= 4'b0110; //xor
                    MemtoReg <= 1;
                    RegWrite <= 1;
                    end
                6'b001010: //slt immediate
                    begin
                    ALUSrc <= 2'b01;
                    ALUop <= 4'b1100; //slt
                    MemtoReg <= 1;
                    RegWrite <= 1;
                    end
                default:
                    begin
                    end
                endcase
        end
    end

endmodule
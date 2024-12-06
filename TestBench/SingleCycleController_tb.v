`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2024 03:56:31 PM
// Design Name: 
// Module Name: SingleCycleController_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SingleCycleController_tb();
    reg [31:0] instruction;
    wire [31:0] AndValue;
    wire [3:0] ALUop;
    wire [1:0] ALUSrc, RegDst, MemtoReg, JumpSrc;
    wire ALUSrc2, Branch, MemRead, MemWrite, Unconditional, BranchNE, MemWriteSrc, RegWrite, RegWriteSrc;
    
 //module SingleCycleController(instruction, ALUSrc, ALUop, ShiftSrc, RegJump, RegDst, Branch, MemRead, 
//MemWrite, Unconditional, BranchNE, MemWriteSrc, MemtoReg, RegWrite, AndValue, RegWriteSrc);   
    SingleCycleController u0(
    .instruction(instruction), 
    .ALUSrc(ALUSrc), 
    .ALUSrc2(ALUSrc2),
    .ALUop(ALUop), 
    //.ShiftSrc(ShiftSrc),
    .JumpSrc(JumpSrc),
    .RegDst(RegDst), 
    .Branch(Branch), 
    .MemRead(MemRead), 
    .MemWrite(MemWrite),
    .Unconditional(Unconditional), 
    .BranchNE(BranchNE), 
    .MemWriteSrc(MemWriteSrc), 
    .MemtoReg(MemtoReg), 
    .RegWrite(RegWrite), 
    .AndValue(AndValue), 
    .RegWriteSrc(RegWriteSrc)

);

initial begin
	
	instruction = 32'b00000001000010000100000000100000; // add
	#10;
    instruction = 32'b00100001000010000000000000001010; //addi
	#10;
    instruction = 32'b00000001000010000100000000100010; //sub
	#10;
    instruction = 32'b01110001000010000000000000000010; //mul
	#10;
    instruction = 32'b10001101000010000000000000000100; //lw
	#10;
    instruction = 32'b10000001000010000000000000000100; //lb
	#10;
    instruction = 32'b10000101000010000000000000000100; // lh
	#10;
    instruction = 32'b10101101000010000000000000000100; //sw
	#10;
    instruction = 32'b10100001000010000000000000000100; // sb
	#10;
    instruction = 32'b10100101000010000000000000000100; //sh
	#10;
    instruction = 32'b00000101000000010000000000100000; // bgez
	#10;
    instruction = 32'b00000101000000000000000000100000; //bltz
	#10;
    instruction = 32'b00011001000010000100000000100000; // blez
	#10;
    instruction = 32'b00011101000010000000000000001010; //bgtz
	#10;
    instruction = 32'b00010001000010000100000000100000; // beq
	#10;
    instruction = 32'b00010101000010000000000000001010; //bne
	#10;
    instruction = 32'b00001001000010000100000000100000; // j
	#10;
    instruction = 32'b00000001000010000000000000001000; //jr
	#10;
    instruction = 32'b00001101000010000100000000100000; // jal
	#10;
    instruction = 32'b00000001000010000000000000100100; //and
	#10;
    instruction = 32'b00000001000010000000000000100101; // or
	#10;
    instruction = 32'b00000001000010000000000000100111; //nor
	#10;
    instruction = 32'b00000001000010000000000000100110; // xor
	#10;
    instruction = 32'b00000001000010000000000000000000; //sll
	#10;
    instruction = 32'b00000001000010000000000000000010; // srl
	#10;
    instruction = 32'b00000001000010000000000000101010; //slt
	#10;
    instruction = 32'b00110001000010000100000000100000; // andi
	#10;
    instruction = 32'b00110101000010000000000000001010; //ori
	#10;
    instruction = 32'b00111001000010000100000000100000; // xori
	#10;
    instruction = 32'b00101001000010000000000000001010; //slti

    $stop;
	end


endmodule

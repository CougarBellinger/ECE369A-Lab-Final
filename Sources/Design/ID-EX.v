`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2024
// Design Name: 
// Module Name: 
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


module DecodeExecute(Clk, Reset, flush, ID_EXWrite, read_data_1_in, read_data_2_in, sa_in, imm_in, rt_in, rd_in, target_in, pc_in, pcJump_in,// inputs
                     ALUSrc_in, ALUASrc_in, ALUop_in, RegJump_in, RegDst_in, // execution control inputs
                     branch_in, MemRead_in, MemWrite_in, Unconditional_in, BranchNE_in, MemWriteSrc_in,  // memory control inputs
                     MemToReg_in, RegWrite_in, AndValue_in, RegWriteSrc_in, // write back control inputs
                     
                     instruction_in, instruction_out,

                     read_data_1_out, read_data_2_out, sa_out, imm_out, rt_out, rd_out, target_out, pc_out, pcJump_out, // outputs
                     ALUSrc_out, ALUASrc_out, ALUop_out, RegJump_out, RegDst_out, // execution control outputs
                     branch_out, MemRead_out, MemWrite_out, Unconditional_out, BranchNE_out, MemWriteSrc_out,  // memory control outputs
                     MemToReg_out, RegWrite_out, AndValue_out, RegWriteSrc_out // write back control outputs
                    ); 

    input Clk, Reset, ID_EXWrite, flush;

    // inputs
    input [31:0] read_data_1_in, read_data_2_in, sa_in, imm_in, target_in, pc_in, pcJump_in, instruction_in;
    input [4:0] rt_in, rd_in; 
   
    // execution control inputs
    input [1:0] ALUSrc_in, RegDst_in, RegJump_in;
    input [3:0] ALUop_in;
    input  ALUASrc_in;

    // memory control inputs
    input branch_in, MemRead_in, MemWrite_in, Unconditional_in, BranchNE_in, MemWriteSrc_in;

    // write back control inputs
    input [1:0] MemToReg_in;
    input [31:0] AndValue_in;
    input RegWrite_in, RegWriteSrc_in;

    //outputs
    output reg [31:0] read_data_1_out, read_data_2_out, sa_out, imm_out, target_out, pc_out, pcJump_out, instruction_out;
    output reg [4:0] rt_out, rd_out;

    // execution control outputs
    output reg [1:0] ALUSrc_out, RegDst_out, RegJump_out;
    output reg [3:0] ALUop_out;
    output reg ALUASrc_out;

    // memory control outputs
    output reg branch_out, MemRead_out, MemWrite_out, Unconditional_out, BranchNE_out, MemWriteSrc_out;

    // write back control outputs
    output reg [1:0] MemToReg_out;
    output reg [31:0] AndValue_out;
    output reg RegWrite_out, RegWriteSrc_out;
    

    always@(posedge Clk)begin
    if(Reset || ID_EXWrite || flush)
    begin
        read_data_1_out <= 0;
        read_data_2_out <= 0;
        sa_out <= 0;
        imm_out <= 0;
        rt_out <= 0;
        rd_out <= 0;
        target_out <= 0;
        pc_out <= 0;
        pcJump_out <= 0;
        instruction_out <= 0;

        // execution control
        ALUSrc_out <= 0;
        ALUASrc_out <= 0;
        ALUop_out <= 0;
        RegJump_out <= 0;
        RegDst_out <= 0;

        // memory control 
        branch_out <= 0;
        MemRead_out <= 0;
        MemWrite_out <= 0;
        Unconditional_out <= 0;
        BranchNE_out <= 0;
        MemWriteSrc_out <= 0;
        
        // write back control 
        MemToReg_out <= 0;
        RegWrite_out <= 0;
        AndValue_out <= 0;
        RegWriteSrc_out <= 0;
    end
    else
    begin
        read_data_1_out <= read_data_1_in;
        read_data_2_out <= read_data_2_in;
        sa_out <= sa_in;
        imm_out <= imm_in;
        rt_out <= rt_in;
        rd_out <= rd_in;
        target_out <= target_in;
        pc_out <= pc_in;
        pcJump_out <= pcJump_in;
        instruction_out <= instruction_in;

        // execution control
        ALUASrc_out <= ALUASrc_in;
        ALUSrc_out <= ALUSrc_in;
        ALUop_out <= ALUop_in;
        RegJump_out <= RegJump_in;
        RegDst_out <= RegDst_in;

        // memory control 
        branch_out <= branch_in;
        MemRead_out <= MemRead_in;
        MemWrite_out <= MemWrite_in;
        Unconditional_out <= Unconditional_in;
        BranchNE_out <= BranchNE_in;
        MemWriteSrc_out <= MemWriteSrc_in;
        
        // write back control 
        MemToReg_out <= MemToReg_in;
        RegWrite_out <= RegWrite_in;
        AndValue_out <= AndValue_in;
        RegWriteSrc_out <= RegWriteSrc_in;
        end
    end

    /*initial begin
        read_data_1_out <= 0;
        read_data_2_out <= 0;
        sa_out <= 0;
        imm_out <= 0;
        rt_out <= 0;
        rd_out <= 0;
        target_out <= 0;
        pc_out <= 0;

        // execution control
        ALUSrc_out <= 0;
        ALUop_out <= 0;
        RegJump_out <= 0;
        RegDst_out <= 0;

        // memory control 
        branch_out <= 0;
        MemRead_out <= 0;
        MemWrite_out <= 0;
        Unconditional_out <= 0;
        BranchNE_out <= 0;
        MemWriteSrc_out <= 0;
        
        // write back control 
        MemToReg_out <= 0;
        RegWrite_out <= 0;
        AndValue_out <= 0;
        RegWriteSrc_out <= 0;
    end*/

        
endmodule

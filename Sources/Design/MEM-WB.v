`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2024 03:56:31 PM
// Design Name: 
// Module Name: SingleCycle
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


module MemoryWriteback(Clk, Reset, MemtoReg_in, RegWrite_in, AndValue_in, RegWriteSrc_in, pc_in, MemData_in, AluResult_in, WriteRegister_in, rt_in, rs_in, MemRead_in, instruction_in,
                            MemtoReg_out, RegWrite_out, AndValue_out, RegWriteSrc_out, pc_out, MemData_out, AluResult_out, WriteRegister_out, rt_out, rs_out, MemRead_out, instruction_out);
    //clk
    input Clk,Reset;

    //datapath information
    input [31:0] pc_in, MemData_in, AluResult_in, instruction_in;
    input [4:0] WriteRegister_in, rt_in, rs_in;
    //control signals
    input [31:0] AndValue_in; //32 bit signal
    input [1:0] MemtoReg_in; //2 bit control signals
    input RegWrite_in, RegWriteSrc_in, MemRead_in; //1 bit control signals

    //datapath information
    output reg [31:0] pc_out, MemData_out, AluResult_out, instruction_out;
    output reg [4:0] WriteRegister_out, rt_out, rs_out;
    //control signals
    output reg [31:0] AndValue_out;  //32 bit signal
    output reg [1:0] MemtoReg_out; //2 bit control signals
    output reg RegWrite_out, RegWriteSrc_out, MemRead_out; //1 bit control signals

    always@(posedge Clk) begin
        if(Reset) begin
            pc_out <= 0;
            MemData_out <= 0;
            AluResult_out <= 0;
            WriteRegister_out <= 0;
            //rt_out <= 0;
            //rs_out <= 0;
            AndValue_out <= 0;
            MemtoReg_out <= 0;
            RegWrite_out <= 0;
            RegWriteSrc_out <= 0;
            MemRead_out <= 0;
            instruction_out <= 0;
        end
        else begin
            //datapath information
            pc_out <= pc_in;
            MemData_out <= MemData_in;
            AluResult_out <= AluResult_in;
            WriteRegister_out <= WriteRegister_in;
            rt_out <= rt_in;
            rs_out <= rs_in;
            instruction_out <= instruction_in;

            //control signals
            AndValue_out <= AndValue_in;
            MemtoReg_out <= MemtoReg_in;
            RegWrite_out <= RegWrite_in;
            RegWriteSrc_out <= RegWriteSrc_in;
            MemRead_out <= MemRead_in;
        end
        end
        
endmodule

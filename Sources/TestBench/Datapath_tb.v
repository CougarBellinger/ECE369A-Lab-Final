`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// / Overall percent effort of each team member: 
// Cougar: 100%
// Eden: 100%
// Jake: 101%
// Create Date: 10/27/2024 02:41:42 PM
// Design Name: 
// Module Name: SingleCycle_tb
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


module TopLevelHazard_tb();

reg Clk;
reg Reset;

wire [31:0] programCounter;
wire [31:0] WriteData;

wire [31:0] v0_data;
wire [31:0] v1_data;

wire [31:0] IF_Instruction;
wire [31:0] ID_Instruction;
wire [31:0] EX_Instruction;
wire [31:0] MEM_Instruction;
wire [31:0] WB_Instruction;

wire [4:0] ID_rt, ID_rs; 
wire [4:0] EX_rt, EX_rd; 
wire [4:0] MEM_rt, MEM_rd;
wire [4:0] WB_rt, WB_rd;

wire EX_MemRead;
wire MEM_MemRead;
wire WB_MemRead;

wire EX_RegWrite;
wire MEM_RegWrite;
    
wire EX_RegWriteSrc;

wire PCsrc, IF_ID_Stall;

TopLevelHazard u0(
    .Reset(Reset),
    .Clk(Clk),
    //IF phase
    .IF_Address(programCounter),
    //ID phase
    .PCsrc(PCsrc), .IF_ID_Stall(IF_ID_Stall),
    .ID_rt(ID_rt), .ID_rs(ID_rs),
    //EX phase
    .EX_rt(EX_rt), .EX_rd(EX_rd),
    //MEM phase
    .MEM_rt(MEM_rt), .MEM_rd(MEM_rd),
    //WB phase
    .WB_WriteData(WriteData),
    .WB_rt(WB_rt), .WB_rd(WB_rd),

    .v0_data (v0_data), .v1_data (v1_data),

    .IF_Instruction (IF_Instruction),
    .ID_Instruction (ID_Instruction),
    .EX_Instruction (EX_Instruction),
    .MEM_Instruction (MEM_Instruction),
    .WB_Instruction (WB_Instruction),

    .EX_MemRead (EX_MemRead), .WB_MemRead (WB_MemRead),
    .EX_RegWrite (EX_RegWrite), .EX_RegWriteSrc (EX_RegWriteSrc),
    .MEM_MemRead (MEM_MemRead), .MEM_RegWrite (MEM_RegWrite)
    
    );
    
initial begin
    Clk <= 1'b0;
    forever #10 Clk <= ~Clk;
    end

initial begin
    //#5;
    Reset = 1;
    #20;
    Reset = 0;
    #20;
end

endmodule

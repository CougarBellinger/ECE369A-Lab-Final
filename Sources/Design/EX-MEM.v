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


module ExecutionMemory(Clk, Reset, pc_in, Zero_in, pc_in_2, ALUResult_in, read_data_2_in, rs_in, rt_in, WriteRegister_in, // datapath inputs
                        pc_out, Zero_out, pc_out_2, ALUResult_out, read_data_2_out, rs_out, rt_out, WriteRegister_out, // datapath outputs

                    instruction_in, instruction_out,

                     AndValue_in, MemtoReg_in, RegWrite_in, RegWriteSrc_in, // writeback control inputs
                     AndValue_out, MemtoReg_out, RegWrite_out, RegWriteSrc_out,// writeback control outputs

                     Branch_in, MemRead_in, MemWrite_in, Unconditional_in, BranchNE_in, MemWriteSrc_in, //memory control inputs
                     Branch_out, MemRead_out, MemWrite_out, Unconditional_out, BranchNE_out, MemWriteSrc_out);//memory control inputs

    input Clk, Reset;

    //datapath information
    input [31:0] pc_in, pc_in_2, ALUResult_in,read_data_2_in, instruction_in;
    input [4:0] WriteRegister_in, rs_in, rt_in ; // 6 bit register location
    input Zero_in; // only 1 bit datapath signal

    output reg [31:0] pc_out, pc_out_2, ALUResult_out, instruction_out;
    output reg [4:0] WriteRegister_out, rs_out, rt_out; // 6 bit register location
    output reg Zero_out;

    //writeback control signals
    input [31:0] AndValue_in; //32 bit signal
    input [1:0] MemtoReg_in; //2 bit control signals
    input RegWrite_in, RegWriteSrc_in; //1 bit control signals

    output reg [31:0] AndValue_out, read_data_2_out; //32 bit signal
    output reg [1:0] MemtoReg_out; //2 bit control signals
    output reg RegWrite_out, RegWriteSrc_out; //1 bit control signals

    //memory control signals
    input Branch_in, MemRead_in, MemWrite_in, Unconditional_in, BranchNE_in, MemWriteSrc_in;
    output reg Branch_out, MemRead_out, MemWrite_out, Unconditional_out, BranchNE_out, MemWriteSrc_out;

    always @ (posedge Clk) begin
        if(Reset) begin
        pc_out <= 0;
        Zero_out <= 0;
        pc_out_2 <= 0;
        ALUResult_out <= 0;
        read_data_2_out <= 0;
        rs_out <= 0;
        rt_out <= 0;
        WriteRegister_out <= 0;
        instruction_out <= 0;

        //writeback control signals
        AndValue_out <= 0;
        MemtoReg_out <= 0;
        RegWrite_out <= 0;
        RegWriteSrc_out <= 0;

        //memory control signals
        Branch_out <= 0;
        MemRead_out <= 0;
        MemWrite_out <= 0;
        Unconditional_out <= 0;
        BranchNE_out <= 0;
        MemWriteSrc_out <= 0;
        end
        //datapath information
        else begin
        pc_out <= pc_in;
        Zero_out <= Zero_in;
        pc_out_2 <= pc_in_2;
        ALUResult_out <= ALUResult_in;
        rs_out <= rs_in;
        rt_out <= rt_in;
        read_data_2_out <= read_data_2_in;
        WriteRegister_out <= WriteRegister_in;
        instruction_out <= instruction_in;

        //writeback control signals
        AndValue_out <= AndValue_in;
        MemtoReg_out <= MemtoReg_in;
        RegWrite_out <= RegWrite_in;
        RegWriteSrc_out <= RegWriteSrc_in;
        //memory control signals
        Branch_out <= Branch_in;
        MemRead_out <= MemRead_in;
        MemWrite_out <= MemWrite_in;
        Unconditional_out <= Unconditional_in;
        BranchNE_out <= BranchNE_in;
        MemWriteSrc_out <= MemWriteSrc_in;
        end
    end

    initial begin 
        
        //datapath information
        pc_out <= 0;
        Zero_out <= 0;
        pc_out_2 <= 0;
        ALUResult_out <= 0;
        rs_out <= 0;
        rt_out <= 0;
        read_data_2_out <= 0;
        WriteRegister_out <= 0;
        instruction_out <= 0;

        //writeback control signals
        AndValue_out <= 0;
        MemtoReg_out <= 0;
        RegWrite_out <= 0;
        RegWriteSrc_out <= 0;
        //memory control signals
        Branch_out <= 0;
        MemRead_out <= 0;
        MemWrite_out <= 0;
        Unconditional_out <= 0;
        BranchNE_out <= 0;
        MemWriteSrc_out <= 0;
    end
        
endmodule
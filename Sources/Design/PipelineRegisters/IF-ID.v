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


module FetchDecode(
    input Clk, Reset,

    input IF_ID_Stall,
    input flush,

    input [31:0] instruction_in,
    input [31:0] pc_in,

    output reg [31:0] instruction_out,
    output reg [31:0] pc_out
);         
        
    always @ (posedge Clk) begin

        if(Reset || flush) begin
            instruction_out <= 0;
            pc_out <= 0;
        end

        else if(~IF_ID_Stall) begin
            instruction_out <= instruction_in;
            pc_out <= pc_in;
        end

    end
        
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Overall percent effort of each team member: 
// Cougar: 100%
// Eden: 100%
// Jake: 100%

//Company: 
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


module TopLevel(Clk, Reset, en_out, out7);
     input Clk, Reset;

     output [7:0] en_out;
     output [6:0] out7;

     wire [31:0] v0_data, v1_data;

     ClkDiv Clk100(
        .Clk(Clk),
        .Rst(Reset),
        .ClkOut(ClkOut)
      );
      
      //defparam Clk100.DivVal = 10000;
    
    TopLevelHazard cpu(
        .Clk(ClkOut), 
        .Reset(Reset),

        .v0_data (v0_data),
        .v1_data (v1_data)
        );

     Two4DigitDisplay Display(
        .Clk(Clk),

        .NumberA(v1_data[7:0]),
        .NumberB(v0_data[7:0]),

        .out7(out7),
        .en_out(en_out)
     );
   //   .NumberA(v0_data[15:0]),
   //      .NumberB(v1_data[15:0]),


endmodule
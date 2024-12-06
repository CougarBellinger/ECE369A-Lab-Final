`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - Mux32Bit2To1.v
// Description - Performs signal multiplexing between 2 32-Bit words.
////////////////////////////////////////////////////////////////////////////////

module Mux5Bit4To1(out, inA, inB, inC, inD, sel);

    output [4:0] out;
    
    input [4:0] inA, inB, inC, inD;
    input [1:0] sel;
    
    // TRUTH TABLE //

    // Sel |  Out  //

    //  00  |  inA  //
    //  01  |  inB  //
    //  10  |  inC  //
    //  11  |  inD  //

    /*always @ (sel)
    begin
        case (sel)
        2'b00: out <= inA;
        2'b01: out <= inB;
        2'b10: out <= inC;
        2'b11: out <= inD;
        endcase
    end*/

    assign out = sel[1] ? (sel[0] ? inD : inC) : (sel[0] ? inB : inA);

endmodule

`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module SignExtension26bit(in, out);

    /* A 26-Bit input word */
    input [25:0] in;
    
    /* A 32-Bit output word */
    output reg [31:0] out;
    
    /* Fill in the implementation here ... */
    always@(*) begin
    
        if(in[25] == 0) begin //checks MSB to see if positive number
            out <= {6'b000000, in}; // concats 0s to the left of 'in'
        end

        if(in[25] == 1) begin //checks MSB to see if negative number
            out <= {6'b111111, in}; // concats 1s to the left of 'in'
        end

    end
endmodule

`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module SignExtension16bit(in, out);

    /* A 16-Bit input word */
    input [15:0] in;
    
    /* A 32-Bit output word */
    output reg [31:0] out;
    
    /* Fill in the implementation here ... */
    always@(*) begin
    
        if(in[15] == 0) begin //checks MSB to see if positive number
            out <= {16'b0000000000000000, in}; // concats 0s to the left of 'in'
        end
        else begin //checks MSB to see if negative number
            out <= {16'b1111111111111111, in}; // concats 1s to the left of 'in'
        end

    end
endmodule

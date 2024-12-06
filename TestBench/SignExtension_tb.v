`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension_tb.v
// Description - Test the sign extension module.
////////////////////////////////////////////////////////////////////////////////

module SignExtension_tb();

    reg	[15:0] in;
    wire [31:0]	out;

	reg [25:0] in_26;
	wire [31:0] out_26;

    SignExtension16bit u0(
        .in(in), .out(out)
    );
	
	SignExtension26bit u1(
		.in(in_26), .out(out_26)
	);

    initial begin

			#100 
			in <= 16'h0004;
			in_26 <= 26'd16;
			#20 $display("in=%h, out=%h", in, out);

			#100 in <= 16'h7000;
			in_26 <= 26'b10000000000000001000000000;
			#20 $display("in=%h, out=%h", in, out);

			#100 in <= 16'h9000;
			#20 $display("in=%h, out=%h", in, out);
			
			#100 in <= 16'hF000;
			#20 $display("in=%h, out=%h", in, out);

			$stop;
			
	 end

endmodule

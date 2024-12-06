`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory 1
// Module - ProgramCounter_tb.v
// Description - Test the 'ProgramCounter.v' module.
////////////////////////////////////////////////////////////////////////////////

module ProgramCounter_tb(); 

	reg [31:0] Address;
	reg Reset, Clk, PCWrite;

	wire [31:0] PCResult;

    ProgramCounter u0(
        .Address(Address), 
        .PCResult(PCResult), 
        .Reset(Reset), 
        .Clk(Clk),
        .PCWrite(PCWrite)
    );

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
		
    /* Please fill in the implementation here... */
        PCWrite <= 0;
		Reset<=0;
		Address<=0; #20;
		Address<=4; #20;
		Address<=8; #20;
		Address<=31; #20;
		Reset<=1; #20;
		Reset <= 0;#20;
		Address <= 2020; #20;
		PCWrite <= 1; #20;
		Address <= 2021;
		#20;#20;#20;
		
		
	end

endmodule


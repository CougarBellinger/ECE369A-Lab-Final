`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory 
// Module - InstructionMemory_tb.v
// Description - Test the 'InstructionMemory_tb.v' module.
////////////////////////////////////////////////////////////////////////////////

module InstructionMemory_tb(); 

    wire [31:0] Instruction;

    reg [31:0] Address;

	InstructionMemory u0(
		.Address(Address),
        .Instruction(Instruction)
	);
	
	initial begin
	Address = 0; #10;
	end

	//initial begin
	
    /* Please fill in the implementation here... */
	/*
		Address = 0; #10;
		Address = 24; #10;
		Address = 48; #10;
		Address = 72; #10;
		Address = 96; #10;
		Address = 120; #10;
		$finish;*/
	
	//end

endmodule


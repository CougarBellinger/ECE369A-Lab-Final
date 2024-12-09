`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
//
//
// Student(s) Name and Last Name: Jake, Eden, Cougar - All 100% effort everytime
//
//
// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//
// 
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////

module RegisterFile(

	input Clk,
	input Reset,

	input RegWrite,

	input [4:0]  WriteRegister,
	input [31:0] WriteData,

	input [4:0] ReadRegister1,
	input [4:0] ReadRegister2,
	
	output reg [31:0] ReadData1,
	output reg [31:0] ReadData2,

	output reg [31:0] s0_data,
	output reg [31:0] s1_data,

	output reg [31:0] v0_data,
	output reg [31:0] v1_data

);

	parameter v0 = 5'd2;
	parameter v1 = 5'd3;

	parameter s0 = 5'd16;
	parameter s1 = 5'd17;

	parameter t9 = 5'd25;

	//integer i;

	reg [31:0] RegFile [0:31];

	always @ (*) begin

		if(Reset) begin
			RegFile[5'd0] <= 0;
			RegFile[5'd29] <= 32'd131067; //initialize $sp to last element of data memory (data mem size - 4)

			v0_data <= 0;
			v1_data <= 0;
		end
		
	end

	//Write on posedge of Clk
	always @ (posedge Clk) begin
		if (RegWrite && (WriteRegister != 5'd0))
			RegFile[WriteRegister] <= WriteData;
	end

	//Read on negedge of Clk
	always @ (negedge Clk) begin
		ReadData1 <= RegFile[ReadRegister1];
		ReadData2 <= RegFile[ReadRegister2];
	end

	always @ (RegFile[s0] or RegFile[s1]) begin
		s0_data <= RegFile[s0];
		s1_data <= RegFile[s1];
	end

	always @ (RegFile[v0] or RegFile[v1]) begin
		v0_data <= RegFile[v0];
		v1_data <= RegFile[v1];
	end

endmodule

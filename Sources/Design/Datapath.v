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


module Datapath (
        //input
        Clk, Reset,

        //Instructions
        IF_Instruction,
        ID_Instruction,
        EX_Instruction,
        MEM_Instruction,
        WB_Instruction,

        WB_WriteData,

        v0_data, v1_data,
        s0_data, s1_data,

        //fetch
        IF_Address, 

        //Registers
        ID_rt, ID_rs,
        EX_rt, EX_rd,
        MEM_rt, MEM_rd,
        WB_rt, WB_rd,

        //Control signals for hazard detection
        EX_MemRead, WB_MemRead,
        EX_RegWrite, EX_RegWriteSrc,
        MEM_MemRead, MEM_RegWrite,

        //HazardSignals
        PCsrc, IF_ID_Stall, ID_EXWrite
);

    input Clk, Reset;

    // Instructions for each stage
    output wire [31:0] IF_Instruction;
    output wire [31:0] ID_Instruction;
    output wire [31:0] EX_Instruction;
    output wire [31:0] MEM_Instruction;
    output wire [31:0] WB_Instruction;

    // Writeback data for testing
    output wire [31:0] WB_WriteData;

    output wire [31:0] v0_data;
    output wire [31:0] v1_data;

    output wire [31:0] s0_data;
    output wire [31:0] s1_data;

    //Writeback wires
    wire [4:0] WB_WriteRegister;
    wire WB_RegWrite;
    wire WB_rs;

    // Program Counter
    output wire [31:0] IF_Address;
    wire [31:0] ID_PC;

    //Memory wires
    wire [31:0] PCJump;
    output wire PCsrc;

    //Hazard Detection
    output wire [4:0] ID_rt, ID_rs;
    output wire [4:0] EX_rt, EX_rd; 
    output wire [4:0] MEM_rt, MEM_rd;
    output wire [4:0] WB_rt, WB_rd;

    output wire EX_MemRead, WB_MemRead;
    output wire EX_RegWrite, EX_RegWriteSrc;
    output wire MEM_MemRead, MEM_RegWrite;

    //Hazard Detection Controls
    output wire IF_ID_Stall;
    output wire ID_EXWrite;
    wire PCWrite, Nop;


    // ==================================================================================================================================================================================================
    // IF
    // ==================================================================================================================================================================================================
    
    wire [31:0] IF_PC; 
    wire [31:0] IF_PCadd;
    wire [31:0] muxRegJump;
    
    Mux32Bit2To1 Mux_PCSrc(
        .sel (PCsrc),

        .inA (IF_PCadd),
        .inB (muxRegJump),

        .out (IF_Address)
    );

    ProgramCounter PC(
        .Clk (Clk),
        .Reset(Reset),
        .PCWrite (PCWrite),
        //input
        .Address (IF_Address),
        //output

        .PCResult (IF_PC)
    );

    PCAdder PCadd(
        .PCResult (IF_PC), //input
        .PCAddResult (IF_PCadd) //output
    );
    
    InstructionMemory InstructionMem(
        .Address (IF_PC),
        .Instruction (IF_Instruction)
    );
    
    // ==================================================================================================================================================================================================
    // IF
    
    //wire [31:0] register_Instruction;
    FetchDecode IFtoID( 
        .Clk (Clk),
        .Reset (Reset),

        .IF_ID_Stall (IF_ID_Stall),
        .flush(PCsrc),

        .instruction_in (IF_Instruction),
        .pc_in (IF_PCadd),

        .instruction_out (ID_Instruction),
        .pc_out(ID_PC)
    );
    // ID
    // ==================================================================================================================================================================================================

    //EX
    wire ID_ALUASrc;
    wire [1:0] ID_ALUSrc, ID_RegDst, ID_RegJump;
    wire [3:0] ID_ALUop;

    //MEM
    wire ID_MemWrite, ID_MemRead, ID_MemWriteSrc;
    wire ID_Unconditional, ID_Branch, ID_BranchNE;

    //BOTH MEM and WB
    wire [31:0] ID_AndValue;

    //WB
    wire ID_RegWrite, ID_RegWriteSrc;
    wire [1:0] ID_MemtoReg;

    //Registers Block
    wire [31:0] ID_readData1, ID_readData2;
    assign ID_rs = ID_Instruction[25:21];
    assign ID_rt = ID_Instruction[20:16];

    //Jumps
    wire [31:0] ID_target32;
    wire [31:0] addJump;
    wire [31:0] shiftImmediate;

    wire [31:0] ID_immed32;
    //-----------------------------------

    //SignExtension
    SignExtension16bit SignExtend32(
        .in (ID_Instruction[15:0]),
        .out(ID_immed32)
    );

    // JUMPS ------------------------------------------------

    //26 bit target --> 32 bit
    assign ID_target32 = {ID_PC[31:28], ID_Instruction[25:0], 2'b00};
    // Shift ID Immediate to be word compatible
    assign shiftImmediate = ID_immed32 << 2;
    // Add jump address to PC
    assign addJump = ID_PC + shiftImmediate;

    // Hazard detection for stall logic
    HazardDetectionUnit HDU(
        .Clk (Clk),
        .Reset (Reset),

        .IF_ID_rs (ID_rs), .IF_ID_rt (ID_rt),

        .ID_EX_rt (EX_rt),   
        .EX_MEM_rt (MEM_rt), 
        .MEM_WB_rt (WB_rt),

        .ID_EX_rd (EX_rd),
        .EX_MEM_rd (MEM_rd),
        .MEM_WB_rd (WB_rd),  

        .MEM_WB_RegWrite (WB_RegWrite),
        .ID_EX_RegWrite (EX_RegWrite),
        .EX_MEM_RegWrite (MEM_RegWrite),

        .ID_EX_MemRead (EX_MemRead),
        .EX_MEM_MemRead (MEM_MemRead),
        .MEM_WB_MemRead (WB_MemRead),

        .PCWrite (PCWrite), .IF_ID_Stall (IF_ID_Stall), .Nop (Nop)
    );

    SingleCycleController Controller(
        //OpCode input
        .instruction_in (ID_Instruction),
        .nop (Nop),

        //Output Signals
        .ALUSrc2 (ID_ALUASrc),
        .ALUSrc (ID_ALUSrc),
        .ALUop (ID_ALUop),
        .JumpSrc (ID_RegJump),
        .RegDst (ID_RegDst),
        .Branch (ID_Branch),
        .MemRead (ID_MemRead),
        .MemWrite (ID_MemWrite),
        .Unconditional (ID_Unconditional),
        .BranchNE (ID_BranchNE),
        .MemWriteSrc (ID_MemWriteSrc),
        .MemtoReg (ID_MemtoReg),
        .RegWrite (ID_RegWrite),
        .AndValue (ID_AndValue),
        .RegWriteSrc (ID_RegWriteSrc)
        //.instruction_out(ID_Instruction)
    );

    RegisterFile Registers(
        //inputs
        .ReadRegister1 (ID_rs),
        .ReadRegister2 (ID_rt),
        .WriteRegister (WB_rd),
        .WriteData (WB_WriteData),
        .RegWrite (WB_RegWrite),
        .Clk (Clk),

        //outputs
        .ReadData1 (ID_readData1),
        .ReadData2 (ID_readData2),

        .v0_data (v0_data),
        .v1_data (v1_data),

        .s0_data (s0_data),
        .s1_data (s1_data)
    );
    
    Mux32Bit4To1 Mux_RegJump(
        .sel (ID_RegJump),
        
        .inA (addJump),     // Output from AddJump
        .inB (ID_readData1), //for jr
        .inC (ID_target32), // for j and jal
        .inD (0), 
        .out (muxRegJump)   // To EX/MEM Register TODO: add to ID/EX Register
    );
     


    // BRANCHING ------------------------------------------------
    wire [31:0] muxBranchALU;
    assign muxBranchALU = ID_ALUASrc ? ID_readData2 : 0;

    wire ALUbranch;
    ALU32Bit ALU_Branch(
        .ALUControl (ID_ALUop),

        //inputs
        .A (ID_readData1),
        .B (ID_readData2),

        //output
        .ALUResult (),
        .Zero (ALUbranch)
    );

    wire muxNotEqual;
    assign muxNotEqual = ID_BranchNE ? ~ALUbranch : ALUbranch; //if MembranchNE = 0 MEM_Zero is sent and gate with memBranch

    // wires for branching logic
    wire andBranch;
    assign andBranch = ID_Branch & muxNotEqual;
    assign PCsrc = ID_Unconditional | andBranch;
    

    // ==================================================================================================================================================================================================
    // ID
    wire [31:0] EX_readData1, EX_readData2, EX_immed32, EX_target, EX_PC;
    wire [31:0] EX_AndValue;
    wire [31:0] EX_sa;
    wire [3:0] EX_ALUop;
    wire [1:0] EX_ALUsrc, EX_RegDst, EX_MemToReg, EX_RegJump;
    wire EX_ALUASrc;
    wire EX_Branch, EX_MemWrite, EX_Unconditional, EX_BranchNE, EX_MemWriteSrc;

    DecodeExecute IDtoEX(
        .Clk (Clk),
        .Reset (Reset),
        .ID_EXWrite(IF_ID_Stall),
        .flush(0),
        
        // inputs----------------------------------
        .read_data_1_in (ID_readData1), .read_data_2_in (ID_readData2), .sa_in ({27'b0,ID_Instruction[10:6]}), .imm_in (ID_immed32),
        .rt_in (ID_rt), .rd_in (ID_Instruction[15:11]), .target_in (ID_target32), .pc_in (ID_PC), .pcJump_in (muxRegJump),
        .instruction_in (ID_Instruction),

        // execution control inputs
        .ALUSrc_in (ID_ALUSrc), .ALUASrc_in(ID_ALUASrc), .ALUop_in(ID_ALUop), .RegJump_in (ID_RegJump), .RegDst_in (ID_RegDst),

        // memory control inputs
        .branch_in (ID_Branch), .MemRead_in(ID_MemRead), .MemWrite_in(ID_MemWrite), .Unconditional_in(ID_Unconditional),
        .BranchNE_in(ID_BranchNE), .MemWriteSrc_in (ID_MemWriteSrc),

        // write back control inputs
        .MemToReg_in (ID_MemtoReg), .RegWrite_in (ID_RegWrite), .AndValue_in (ID_AndValue), .RegWriteSrc_in (ID_RegWriteSrc),


        // outputs----------------------------------
        .ALUASrc_out(EX_ALUASrc), .read_data_1_out (EX_readData1), .read_data_2_out (EX_readData2), .sa_out (EX_sa), .imm_out (EX_immed32),
        .rt_out(EX_rt), .rd_out (EX_rd), .target_out (EX_target), .pc_out (EX_PC), .pcJump_out (PCJump),
        .instruction_out (EX_Instruction),

        // execution control outputs
        .ALUSrc_out (EX_ALUsrc), .ALUop_out (EX_ALUop), .RegJump_out (EX_RegJump), .RegDst_out (EX_RegDst),

        // memory control outputs
        .branch_out (EX_Branch), .MemRead_out (EX_MemRead), .MemWrite_out (EX_MemWrite), .Unconditional_out (EX_Unconditional),
        .BranchNE_out (EX_BranchNE), .MemWriteSrc_out (EX_MemWriteSrc),

        // write back control outputs
        .MemToReg_out (EX_MemToReg), .RegWrite_out (EX_RegWrite), .AndValue_out (EX_AndValue), .RegWriteSrc_out (EX_RegWriteSrc)
    );
    // EX
    // ==================================================================================================================================================================================================

    
    // ALU ------------------------------------------------
    //Mux for ALU input A
     wire [31:0] muxALUASrc;
    
    Mux32Bit2To1 Mux_ALUASrc(
        .sel (EX_ALUASrc),

        .inA(EX_readData1),
        .inB(EX_readData2),

        .out(muxALUASrc)
    );
    //Mux for ALU input B
     wire [31:0] muxAluSrc;
    Mux32Bit4To1 Mux_AluSrc(
        .sel (EX_ALUsrc),

        .inA (EX_readData2),
        .inB (EX_immed32),
        .inC (0),
        .inD (EX_sa),

        .out (muxAluSrc)
    );

    // ALU
     wire [63:0] ALUresult;
     wire zero;
    ALU32Bit ALU(
        .ALUControl (EX_ALUop),

        //inputs
        .A (muxALUASrc),
        .B (muxAluSrc),

        //output
        .ALUResult (ALUresult),
        .Zero (zero)
    );

    // WRITE REGISTER ------------------------------------------
    wire [4:0] muxRegDst;
    Mux5Bit4To1 Mux_RegDst(
        .sel (EX_RegDst), //RegDst Signal

        .inA (EX_rt), // Instr rt
        .inB (EX_rd), // Instr rd
        .inC (5'd31),
        .inD (5'b0), // Not needed

        .out (muxRegDst)
    );

    // ==================================================================================================================================================================================================
    // EX

    //datapath wires
    wire [31:0] MEM_PC, MEM_ALUresult, MEM_readData2;
    wire [4:0] MEM_WriteReg, MEM_rs;
    wire MEM_Zero;

    //writeback control wires
    wire [31:0] MEM_AndValue;
    wire [1:0] MEM_MemToReg;
    wire MEM_RegWriteSrc;

    //memory control wires
    wire MEM_Branch, MEM_Unconditional;
    wire MEM_MemWrite, MEM_BranchNE, MEM_WriteSrc;

    ExecutionMemory EXtoMEM(
        .Clk (Clk),
        .Reset (Reset),
        // datapath inputs
        .pc_in (muxRegJump), .Zero_in (zero), .pc_in_2 (EX_PC), .ALUResult_in (ALUresult[31:0]),
        .rt_in (EX_rt), .rs_in (EX_rs), .read_data_2_in(EX_readData2), .WriteRegister_in (muxRegDst),
        .instruction_in (EX_Instruction),
        // datapath outputs
        .pc_out (), .Zero_out (MEM_Zero), .pc_out_2 (MEM_PC), .ALUResult_out (MEM_ALUresult),
        .rt_out (MEM_rt), .rs_out (MEM_rs), .read_data_2_out(MEM_readData2), .WriteRegister_out (MEM_rd),
        .instruction_out (MEM_Instruction),

        // writeback control inputs
        .AndValue_in (EX_AndValue), .MemtoReg_in (EX_MemToReg), .RegWrite_in (EX_RegWrite), .RegWriteSrc_in (EX_RegWriteSrc),
        //writeback control outputs
        .AndValue_out (MEM_AndValue), .MemtoReg_out (MEM_MemToReg), .RegWrite_out (MEM_RegWrite), .RegWriteSrc_out (MEM_RegWriteSrc),

        //memory control inputs
        .Branch_in (EX_Branch), .MemRead_in (EX_MemRead), .MemWrite_in (EX_MemWrite), .Unconditional_in (EX_Unconditional),
        .BranchNE_in (EX_BranchNE), .MemWriteSrc_in (EX_MemWriteSrc),
        //memory control outputs
        .Branch_out (MEM_Branch), .MemRead_out (MEM_MemRead), .MemWrite_out (MEM_MemWrite), .Unconditional_out (MEM_Unconditional),
        .BranchNE_out (MEM_BranchNE), .MemWriteSrc_out (MEM_WriteSrc)
    );
    // MEM
    // ==================================================================================================================================================================================================

    // DATA MEMORY ------------------------------------------------
    // wire for lh & lb instructions
    wire [31:0] andFilter;
    assign andFilter = MEM_readData2 & MEM_AndValue;

    // mux for write src
     wire [31:0] muxMemWriteSrc;
    Mux32Bit2To1 Mux_MemWriteSrc(
        .sel(MEM_WriteSrc), //MemWriteSrc

        .inA(MEM_readData2), //ReadData2
        .inB(andFilter), //andFilter

        .out(muxMemWriteSrc) 
    );

    wire [31:0] readDataMem;
    DataMemory DataMemory(
        .Address (MEM_ALUresult), //ALU Result
        .WriteData (muxMemWriteSrc),
        .Clk (Clk),
        .MemWrite (MEM_MemWrite),
        .MemRead (MEM_MemRead),
        .ReadData(readDataMem)
    );

    wire [31:0] iterate_PC;
    assign iterate_PC = MEM_PC; //+4 removed

    // ==================================================================================================================================================================================================
    // MEM

    wire [31:0] WB_AndValue, WB_PCout, WB_ALUResult;
     wire [31:0] WB_MemData;
     wire [1:0] WB_MemToReg;
     wire WB_RegWriteSrc;

    MemoryWriteback MEMtoWB(
        .Clk (Clk),
        .Reset (Reset),
        // Datapath inputs
        .MemData_in (readDataMem), .AluResult_in (MEM_ALUresult), .WriteRegister_in (MEM_rd), .pc_in (iterate_PC), .rt_in(MEM_rt), .rs_in(MEM_rs), .MemRead_in (MEM_MemRead),
        .instruction_in (MEM_Instruction),
        // Memory control inputs
        .MemtoReg_in (MEM_MemToReg), .RegWrite_in (MEM_RegWrite), .AndValue_in (MEM_AndValue), .RegWriteSrc_in (MEM_RegWriteSrc), 

        // Memory outputs
        .MemtoReg_out (WB_MemToReg), .RegWrite_out (WB_RegWrite), .AndValue_out (WB_AndValue), .RegWriteSrc_out (WB_RegWriteSrc), .rt_out (WB_rt), .rs_out(WB_rs), .MemRead_out (WB_MemRead),
        // Datapath outputs
        .MemData_out (WB_MemData), .AluResult_out (WB_ALUResult), .WriteRegister_out (WB_rd), .pc_out (WB_PCout),
        .instruction_out (WB_Instruction)
    );

    // WB
    // ==================================================================================================================================================================================================

     wire [31:0] muxMemToReg;
    Mux32Bit4To1 Mux_MemToReg(
        .sel(WB_MemToReg),

        .inA(WB_MemData),
        .inB(WB_ALUResult),
        .inC(WB_PCout),
        .inD(0),

        .out(muxMemToReg) 
    );

    wire [31:0] filter;
    assign filter = WB_AndValue & muxMemToReg;
    
    Mux32Bit2To1 Mux_WriteData(
        .sel(WB_RegWriteSrc),

        .inA(muxMemToReg),
        .inB(filter),

        .out(WB_WriteData)
    );


endmodule

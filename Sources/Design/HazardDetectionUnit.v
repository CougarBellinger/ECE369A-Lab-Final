`timescale 1ns / 1ps

module HazardDetectionUnit (
    input Clk,
    input Reset,

    input [31:0] ID_Instruction,

    input [4:0] ID_rs, ID_rt,

    input [4:0] EX_rt, EX_rd,
    input [4:0] MEM_rt, MEM_rd,
    input [4:0] WB_rt, WB_rd,

    input EX_MemRead,
    input MEM_MemRead,
    input WB_MemRead,

    input EX_RegWrite,
    input MEM_RegWrite,
    input WB_RegWrite,

    output reg PCWrite,
    output reg IF_ID_Stall,
    output reg ID_EX_Stall,
    output reg Nop
);

reg stall;
reg exit;

reg ID_Branch;

reg EX_rt_match;
reg MEM_rt_match;
reg WB_rt_match;

reg EX_rd_match;
reg MEM_rd_match;
reg WB_rd_match;

reg ID_EX_trigger; 
reg EX_MEM_trigger;
reg MEM_WB_trigger;

reg EX_dependant;
reg MEM_dependant;
reg WB_dependant;

always @ (*) begin

    if (Reset) begin
        stall <= 0;
        exit <= 0;
        ID_Branch <= 0;
    end

    else begin

        case(ID_Instruction[31:26])
            6'b000001:  ID_Branch <= 1;
            6'b000110:  ID_Branch <= 1;
            6'b000111:  ID_Branch <= 1;
            6'b000100:  ID_Branch <= 1;
            6'b000101:  ID_Branch <= 1;
            default:    ID_Branch <= 0;
        endcase

        //1 if [stage]_rd = ID_rs or ID_rt
        EX_rd_match  = ((EX_rd == ID_rs) & (ID_rs != 5'd0)) | ((EX_rd == ID_rt) & (ID_rt != 5'd0));
        MEM_rd_match = ((MEM_rd == ID_rs) & (ID_rs != 5'd0)) | ((MEM_rd == ID_rt) & (ID_rt != 5'd0));
        WB_rd_match  = ((WB_rd == ID_rs) & (ID_rs != 5'd0)) | ((WB_rd == ID_rt) & (ID_rt != 5'd0));

        //1 if [stage]_rt = ID_rs or ID_rt
        EX_rt_match  = ((EX_rt == ID_rs) & (ID_rs != 5'd0)) | ((EX_rt == ID_rt) & (ID_rt != 5'd0));
        MEM_rt_match = ((MEM_rt == ID_rs) & (ID_rs != 5'd0)) | ((MEM_rt == ID_rt) & (ID_rt != 5'd0));
        WB_rt_match  = ((WB_rt == ID_rs) & (ID_rs != 5'd0)) | ((WB_rt == ID_rt) & (ID_rt != 5'd0));

        //1 if IF_ID is dependant on respective stage
        EX_dependant  = (EX_MemRead | ID_Branch) & (EX_rt_match | EX_rd_match);
        MEM_dependant = (MEM_MemRead | ID_Branch) & (MEM_rt_match | MEM_rd_match);
        WB_dependant  = (WB_MemRead | ID_Branch) & (WB_rt_match | WB_rd_match);

        //1 if dependency exists
        stall = EX_dependant | MEM_dependant | WB_dependant;

    end
    
    if (stall) begin
        PCWrite <= 1; 
        IF_ID_Stall <= 1;
        ID_EX_Stall <= 1;
        Nop <= 1;
    end

    else begin
        PCWrite <= 0; 
        IF_ID_Stall <= 0;
        ID_EX_Stall <= 0;
        Nop <= 0;
    end
    
end

always @ (negedge stall) begin
    PCWrite <= 1; 
    IF_ID_Stall <= 1;
    ID_EX_Stall <= 1;
    Nop <= 1;

    exit <= 1;
end

always @ (posedge Clk) begin
    if (exit) begin
        PCWrite <= 0; 
        IF_ID_Stall <= 0;
        ID_EX_Stall <= 0;
        Nop <= 0;

        exit <= 0;
    end
end

endmodule
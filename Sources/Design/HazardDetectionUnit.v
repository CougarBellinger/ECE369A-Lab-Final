`timescale 1ns / 1ps

module HazardDetectionUnit (
    input Clk,
    input Reset,

    input [4:0] IF_ID_rs, IF_ID_rt,
    input IF_ID_Branch,

    input [4:0] ID_EX_rt, ID_EX_rd,
    input [4:0] EX_MEM_rt, EX_MEM_rd,
    input [4:0] MEM_WB_rt, MEM_WB_rd,

    input ID_EX_MemRead,
    input EX_MEM_MemRead,
    input MEM_WB_MemRead,

    input ID_EX_RegWrite,
    input EX_MEM_RegWrite,
    input MEM_WB_RegWrite,

    output reg PCWrite,
    output reg IF_ID_Stall,
    output reg ID_EX_Stall,
    output reg Nop
);

reg stall;
reg exit;

reg ID_EX_rt_match;
reg EX_MEM_rt_match;
reg MEM_WB_rt_match;

reg ID_EX_rd_match;
reg EX_MEM_rd_match;
reg MEM_WB_rd_match;

reg ID_EX_trigger; 
reg EX_MEM_trigger;
reg MEM_WB_trigger;

reg ID_EX_dependant;
reg EX_MEM_dependant;
reg MEM_WB_dependant;

always @ (*) begin

    if (Reset) begin
        stall <= 0;
        exit <= 0;
    end

    else begin

        //1 if [stage]_rd = IF_ID_rs or IF_ID_rt
        ID_EX_rd_match  = ((ID_EX_rd == IF_ID_rs) & (IF_ID_rs != 5'd0)) | ((ID_EX_rd == IF_ID_rt) & (IF_ID_rt != 5'd0));
        EX_MEM_rd_match = ((EX_MEM_rd == IF_ID_rs) & (IF_ID_rs != 5'd0)) | ((EX_MEM_rd == IF_ID_rt) & (IF_ID_rt != 5'd0));
        MEM_WB_rd_match = ((MEM_WB_rd == IF_ID_rs) & (IF_ID_rs != 5'd0)) | ((MEM_WB_rd == IF_ID_rt) & (IF_ID_rt != 5'd0));

        //1 if [stage]_rt = IF_ID_rs or IF_ID_rt
        ID_EX_rt_match  = ((ID_EX_rt == IF_ID_rs) & (IF_ID_rs != 5'd0)) | ((ID_EX_rt == IF_ID_rt) & (IF_ID_rt != 5'd0));
        EX_MEM_rt_match = ((EX_MEM_rt == IF_ID_rs) & (IF_ID_rs != 5'd0)) | ((EX_MEM_rt == IF_ID_rt) & (IF_ID_rt != 5'd0));
        MEM_WB_rt_match = ((MEM_WB_rt == IF_ID_rs) & (IF_ID_rs != 5'd0)) | ((MEM_WB_rt == IF_ID_rt) & (IF_ID_rt != 5'd0));

        //1 if IF_ID is dependant on respective stage
        ID_EX_dependant  = (ID_EX_MemRead & ID_EX_rt_match) | (ID_EX_rd_match & IF_ID_Branch);
        EX_MEM_dependant = (EX_MEM_MemRead & EX_MEM_rt_match) | (EX_MEM_rd_match & IF_ID_Branch);
        MEM_WB_dependant = (MEM_WB_MemRead & MEM_WB_rt_match) | (MEM_WB_rd_match & IF_ID_Branch);

        //1 if dependency exists
        stall = ID_EX_dependant | EX_MEM_dependant | MEM_WB_dependant;

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
`timescale 1ns / 1ps

module HDU_tb();

reg [4:0] IF_ID_rs, IF_ID_rt, 
            ID_EX_rt, ID_EX_rd,
            EX_MEM_rt, EX_MEM_rd,
            MEM_WB_rt, MEM_WB_rd;

reg ID_EX_MemRead, EX_MEM_MemRead, MEM_WB_MemRead, MEM_WB_RegWrite, ID_EX_RegWrite, EX_MEM_RegWrite;

wire PCWrite, IF_IDWrite, Nop;

HazardDetectionUnit u0 (
        .IF_ID_rs(IF_ID_rs), 
        .IF_ID_rt(IF_ID_rt),
        .ID_EX_rt(ID_EX_rt), 
        .ID_EX_rd(ID_EX_rd),
        .EX_MEM_rt(EX_MEM_rt), 
        .EX_MEM_rd(EX_MEM_rd),
        .MEM_WB_rt(MEM_WB_rt), 
        .MEM_WB_rd(MEM_WB_rd),
        .MEM_WB_RegWrite(MEM_WB_RegWrite),
        .ID_EX_MemRead(ID_EX_MemRead), 
        .EX_MEM_MemRead(EX_MEM_MemRead), 
        .MEM_WB_MemRead(MEM_WB_MemRead),
        .ID_EX_RegWrite(ID_EX_RegWrite), 
        .EX_MEM_RegWrite(EX_MEM_RegWrite),
        .PCWrite(PCWrite), 
        .IF_IDWrite(IF_IDWrite), 
        .Nop(Nop)
    );

 initial begin
        
        IF_ID_rs = 0;
        IF_ID_rt = 0;
        ID_EX_rt = 0;
        ID_EX_rd = 0;
        EX_MEM_rt = 0;
        EX_MEM_rd = 0;
        MEM_WB_rt = 0;
        MEM_WB_rd = 0;
        ID_EX_MemRead = 0;
        EX_MEM_MemRead = 0;
        MEM_WB_MemRead = 0;
        ID_EX_RegWrite = 0;
        EX_MEM_RegWrite = 0;

        #100
        // lw in EX
        ID_EX_MemRead = 1;
        ID_EX_rt = 5'b00011;
        IF_ID_rs = 5'b00011;

        #100
        // lw in MEM
        ID_EX_MemRead = 0;
        EX_MEM_MemRead = 1;
        EX_MEM_rt = 5'b00101;
        IF_ID_rs = 5'b00101;

        #100
        // lw in WB
        EX_MEM_MemRead = 0;
        MEM_WB_MemRead = 1;
        MEM_WB_rt = 5'b00111;
        IF_ID_rs = 5'b00111;

        #100
        // rd in EX
        MEM_WB_MemRead = 0;
        ID_EX_RegWrite = 1;
        ID_EX_rd = 5'b01000;
        IF_ID_rt = 5'b01000;

        #100
        // rd in MEM
        ID_EX_RegWrite = 0;
        EX_MEM_RegWrite = 1;
        EX_MEM_rd = 5'b01010;
        IF_ID_rs = 5'b01010;

        #100
        // rd in WB
        EX_MEM_RegWrite = 0;
        MEM_WB_RegWrite = 1;
        MEM_WB_rd = 5'b01011;
        IF_ID_rs = 5'b01011;
 end

 endmodule
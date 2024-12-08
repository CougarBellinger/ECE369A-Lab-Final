`timescale 1ns / 1ps

module ForwardingUnit (
    input Clk,
    input Reset,

    input [4:0] ID_EX_rs, ID_EX_rt,

    input [4:0] EX_MEM_rt, EX_MEM_rd,
    input [4:0] MEM_WB_rt, MEM_WB_rd,

    input [1:0] EX_MEM_ALUSrc,
    input [1:0] MEM_WB_ALUSrc,

    input EX_MEM_MemRead,
    input MEM_WB_MemRead,

    input EX_MEM_RegWrite,
    input MEM_WB_RegWrite,

    output reg [1:0] Forward_rs_EX,
    output reg [1:0] Forward_rt_EX

);

reg EX_MEM_imm;
reg MEM_WB_imm;

reg EX_MEM_rt_match_rs;
reg MEM_WB_rt_match_rs;

reg EX_MEM_rd_match_rs;
reg MEM_WB_rd_match_rs;

reg EX_MEM_rt_match_rt;
reg MEM_WB_rt_match_rt;

reg EX_MEM_rd_match_rt; 
reg MEM_WB_rd_match_rt;

reg trigger_rs;
reg trigger_rt;

reg EX_MEM_dependant;
reg MEM_WB_dependant;

always @ (*) begin

    if (Reset) begin
        trigger_rs <= 0;
        trigger_rt <= 0;
    end

    else begin

        //1 if [stage] is an immed instr
        EX_MEM_imm = ~EX_MEM_ALUSrc[0] & EX_MEM_ALUSrc[1];
        MEM_WB_imm = ~MEM_WB_ALUSrc[0] & MEM_WB_ALUSrc[1];

        // RS Dependancy----
        //1 if [stage]_rt = ID_EX_rs
        EX_MEM_rt_match_rs = (EX_MEM_rt == ID_EX_rs) & (ID_EX_rs != 5'd0) & EX_MEM_imm;
        MEM_WB_rt_match_rs = (MEM_WB_rt == ID_EX_rs) & (ID_EX_rs != 5'd0) & MEM_WB_imm;

        //1 if [stage]_rd = ID_EX_rs
        EX_MEM_rd_match_rs = (EX_MEM_rd == ID_EX_rs) & (ID_EX_rs != 5'd0);
        MEM_WB_rd_match_rs = (MEM_WB_rd == ID_EX_rs) & (ID_EX_rs != 5'd0);
        // -----------------

        // RT Dependancy----
        //1 if [stage]_rt = ID_EX_rt
        EX_MEM_rt_match_rt = (EX_MEM_rt == ID_EX_rt) & (ID_EX_rt != 5'd0) & EX_MEM_imm;
        MEM_WB_rt_match_rt = (MEM_WB_rt == ID_EX_rt) & (ID_EX_rt != 5'd0) & MEM_WB_imm;

        //1 if [stage]_rd = ID_EX_rt
        EX_MEM_rd_match_rt = (EX_MEM_rd == ID_EX_rt) & (ID_EX_rt != 5'd0);
        MEM_WB_rd_match_rt = (MEM_WB_rd == ID_EX_rt) & (ID_EX_rt != 5'd0);
        //------------------

        //1 if [stage]_MemRead and dependency present
        trigger_rs = (MEM_WB_RegWrite | EX_MEM_RegWrite) & (EX_MEM_rt_match_rs | MEM_WB_rt_match_rs | EX_MEM_rd_match_rs | MEM_WB_rd_match_rs);
        trigger_rt = (MEM_WB_RegWrite | EX_MEM_RegWrite) & (EX_MEM_rt_match_rt | MEM_WB_rt_match_rt | EX_MEM_rd_match_rt | MEM_WB_rd_match_rt);

    end

    if(trigger_rs || trigger_rt)begin

        Forward_rs_EX[0] <= trigger_rs;
        Forward_rs_EX[1] = ~(EX_MEM_rt_match_rs & EX_MEM_rd_match_rs) | (MEM_WB_rt_match_rs | MEM_WB_rd_match_rs);

        Forward_rt_EX[0] <= trigger_rt;
        Forward_rt_EX[1] = ~(EX_MEM_rt_match_rt & EX_MEM_rd_match_rt) | (MEM_WB_rt_match_rt | MEM_WB_rd_match_rt);
        
    end

    else begin

        Forward_rs_EX <= 2'd0;
        Forward_rt_EX <= 2'd0;

    end
    
end

endmodule
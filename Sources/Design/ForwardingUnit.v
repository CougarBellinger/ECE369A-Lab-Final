`timescale 1ns / 1ps

module ForwardingUnit (
    input Clk,
    input Reset,

    input [4:0] ID_rs, ID_rt,
    
    input [4:0] EX_rt, EX_rd, EX_rs,
    input [4:0] MEM_rt, MEM_rd,
    input [4:0] WB_rt, WB_rd,

    input [1:0] EX_ALUSrc,
    input [1:0] MEM_ALUSrc,
    input [1:0] WB_ALUSrc,

    input EX_MemRead,
    input MEM_MemRead,
    input WB_MemRead,

    input EX_RegWrite,
    input MEM_RegWrite,
    input WB_RegWrite,

    output reg [1:0] Forward_ID_rs,
    output reg [1:0] Forward_ID_rt,
    output reg [1:0] Forward_EX_rs,
    output reg [1:0] Forward_EX_rt
);

reg MEM_rt_match_EX_rs;
reg MEM_rd_match_EX_rs;
reg WB_rt_match_EX_rs;
reg WB_rd_match_EX_rs;

reg MEM_rt_match_EX_rt;
reg MEM_rd_match_EX_rt;
reg WB_rt_match_EX_rt;
reg WB_rd_match_EX_rt;

reg trigger_EX_rs;
reg trigger_EX_rt;

always @ (*) begin

    if (Reset) begin

        trigger_EX_rs <= 0;
        trigger_EX_rt <= 0;
        Forward_EX_rs <= 2'd0;
        Forward_EX_rt <= 2'd0;

    end

    else begin

        //1 if [stage]_rt or [stage]_rd = EX_rs
        MEM_rt_match_EX_rs = (MEM_rt == EX_rs) & (EX_rs != 5'd0) & (MEM_ALUSrc == 2'b01);
        MEM_rd_match_EX_rs = (MEM_rd == EX_rs) & (EX_rs != 5'd0);
        WB_rt_match_EX_rs = (WB_rt == EX_rs) & (EX_rs != 5'd0) & (WB_ALUSrc == 2'b01);
        WB_rd_match_EX_rs = (WB_rd == EX_rs) & (EX_rs != 5'd0);
        
        if (EX_ALUSrc == 2'b00) begin

            //1 if [stage]_rt or [stage]_rd = EX_rt
            MEM_rt_match_EX_rt = (MEM_rt == EX_rt) & (EX_rt != 5'd0) & (MEM_ALUSrc == 2'b01);
            MEM_rd_match_EX_rt = (MEM_rd == EX_rt) & (EX_rt != 5'd0);
            WB_rt_match_EX_rt = (WB_rt == EX_rt) & (EX_rt != 5'd0) & (WB_ALUSrc == 2'b01);
            WB_rd_match_EX_rt = (WB_rd == EX_rt) & (EX_rt != 5'd0);

        end

        //1 if [stage]RegWrite and dependency present
        trigger_EX_rs = (WB_RegWrite | MEM_RegWrite) & ~(EX_MemRead)
                        & ( ((MEM_rt_match_EX_rs | MEM_rd_match_EX_rs) & ~MEM_MemRead)
                            | ((WB_rt_match_EX_rs | WB_rd_match_EX_rs) & ~WB_MemRead) );

        trigger_EX_rt = (WB_RegWrite | MEM_RegWrite) & ~(EX_MemRead) 
                        & ( ((MEM_rt_match_EX_rt | MEM_rd_match_EX_rt) & ~MEM_MemRead)
                            | ((WB_rt_match_EX_rt | WB_rd_match_EX_rt) & ~WB_MemRead) );            

    end

    if (trigger_EX_rs || trigger_EX_rt) begin

        Forward_EX_rs[1] = trigger_EX_rs;
        Forward_EX_rs[0] = ~(MEM_rt_match_EX_rs | MEM_rd_match_EX_rs) | (WB_rt_match_EX_rs | WB_rd_match_EX_rs);

        Forward_EX_rt[1] = trigger_EX_rt;
        Forward_EX_rt[0] = ~(MEM_rt_match_EX_rt | MEM_rd_match_EX_rt) | (WB_rt_match_EX_rt | WB_rd_match_EX_rt);

    end

    else begin

        Forward_EX_rs <= 2'd0;
        Forward_EX_rt <= 2'd0;

        trigger_EX_rs = 0;
        trigger_EX_rt = 0;

    end

end

endmodule
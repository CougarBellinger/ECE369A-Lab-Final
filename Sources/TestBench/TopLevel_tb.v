`timescale 1ps/1ps

module TopLevel_tb ();

reg Clk;
reg Reset;

TopLevel display(
    .Clk (Clk),
    .Reset (Reset)
);

initial begin
    Clk <= 1'b0;
    forever #10 Clk <= ~Clk;
end

initial begin
    //#5;
    Reset = 1;
    #20;
    Reset = 0;
    #20;
end

endmodule
module Two4DigitDisplay_tb();

reg Clk, Reset;

wire [31:0] v0_data, v1_data;

TopLevelHazard cpu(
        .Clk(Clk), 
        .Reset(Reset),
        .v0_data(v0_data),
        .v1_data(v1_data)
);

Two4DigitDisplay test(
    .Clk (Clk), .NumberA (v0_data[15:0]), .NumberB (v1_data[15:0])
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
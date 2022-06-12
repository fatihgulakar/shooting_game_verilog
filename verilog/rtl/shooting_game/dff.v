module dff(
    input d,
    input clk,
    output q
);
    always@(posedge clk)
        q <= d;

endmodule
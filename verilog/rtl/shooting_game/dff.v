module dff(
    input d,
    input clk,
    output q
);
    always@(posedge clk) begin
        q <= d;
    end
endmodule

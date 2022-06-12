module freq_divider #(
  parameter n = 100
)(
  input  in_clk,
  input  reset,
  output out_clk
);

reg [$clog2(n) - 1:0] counter = 1'b0;

always @(posedge in_clk or posedge reset) begin
  if(reset) begin
    counter <= 0;
  end else begin
    counter <= counter + 1;
  end
end

assign out_clk = counter[$clog2(n) - 1];

endmodule

module freq_divider #(
  parameter nbits = 4
)(
  input  in_clk,
  input  reset,
  output out_clk
);

reg [nbits - 1:0] counter;

always @(posedge in_clk or posedge reset) begin
  if(reset) begin
    counter <= 0;
  end else begin
    counter <= counter + 1;
  end
end

assign out_clk = counter[nbits - 1];

endmodule

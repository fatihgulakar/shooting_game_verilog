module debouncer #(
  parameter num_stage = 4
)(
  input wire in,
  input wire clk,
  output wire out
);

  wire [num_stage:0] stages;

  assign stages[0] = in;


  genvar i;
  generate
    for(i=0; i<num_stage; i=i+1) begin
      dff stage(
        .d    (stages[i]),
        .clk  (clk),
        .q    (stages[i+1])
      );
    end
  endgenerate

  assign out = &stages[num_stage:1];

endmodule

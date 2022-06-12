module debouncer(
  input wire in,
  input wire clk,
  output wire out
);

  wire sig1;
  wire sig2;
  wire sig3;
  wire sig4;

  dff ex0(
    .q(sig1),
    .clk(clk),
    .d(in)
  );

  dff ex1(
    .q(sig2),
    .clk(clk),
    .d(sig1)
  );

  dff ex2(
    .q(sig3),
    .clk(clk),
    .d(sig2)
  );

  dff ex3(
    .q(sig4),
    .clk(clk),
    .d(sig3)
  );

  assign out = sig1 & sig4 & sig3 & sig2;

endmodule

module kb2game(
  input            board_clk,
  input            reset,
  input            ps2_clk,
  input            ps2_data,
  output reg [4:0] p1, // 0 to 4 up down left right shoot
  output reg [4:0] p2  // 0 to 4 up down left right shoot
);

  wire clk;
  wire [7:0] data;
  wire data_break = 1'b0; 

  //P1 keys
  parameter P1_u = 8'h1D;  // W
  parameter P1_d = 8'h1B;  // S
  parameter P1_l = 8'h1C;  // A
  parameter P1_r = 8'h23;  // D
  parameter P1_s = 8'h3B;  // J
  //P2 keys
  parameter P2_u = 8'h75;  // ^
  parameter P2_d = 8'h72;  // v
  parameter P2_l = 8'h6B;  // <
  parameter P2_r = 8'h74;  // >
  parameter P2_s = 8'h4C;  // S.

  freq_divider #(
    .nbits(1)
  ) n1(
    .in_clk  (board_clk),
    .reset   (reset),
    .out_clk (clk)
  );

  //50 MHz clock
  kb n2(
    ps2_clk,
    ps2_data,
    clk,
    data,
    data_break);

  always@(posedge clk) begin
    case(data)
      P2_u: p2[0] <= data_break ? 1'b0 : 1'b1;
      P2_d: p2[1] <= data_break ? 1'b0 : 1'b1;
      P2_l: p2[2] <= data_break ? 1'b0 : 1'b1;
      P2_r: p2[3] <= data_break ? 1'b0 : 1'b1;
      P2_s: p2[4] <= data_break ? 1'b0 : 1'b1;
      P1_u: p1[0] <= data_break ? 1'b0 : 1'b1;
      P1_d: p1[1] <= data_break ? 1'b0 : 1'b1;
      P1_l: p1[2] <= data_break ? 1'b0 : 1'b1;
      P1_r: p1[3] <= data_break ? 1'b0 : 1'b1;
      P1_s: p1[4] <= data_break ? 1'b0 : 1'b1;
    endcase
  end


endmodule

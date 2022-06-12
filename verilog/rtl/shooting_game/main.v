//--------------------------------------------------------------------------------
// 1v1 two player shooting game code implemented on nexys3 board
//--------------------------------------------------------------------------------

module main(
  input             ps2_data,
  input             ps2_clk,
  input             board_clk,
  input             start,
  input             reset,
  output wire       hsync,
  output wire       vsync,
  output wire [2:0] red,
  output wire [2:0] green,
  output wire [1:0] blue
);

  wire [31:0] column;
  wire [31:0] row;
  wire        game_clk; 
  wire        vga_clk;
  wire        disp_en;
  wire [4:0]  p1_control; 
  wire [4:0]  p2_control;

  color_generator color(
    .game_clk   (game_clk),
    .vga_clk    (vga_clk),
    .disp_en    (disp_en),
    .p1_control (p1_control),
    .p2_control (p2_control),
    .start      (start),
    .reset      (reset),
    .column     (column),
    .row        (row),
    .red        (red),
    .green      (green),
    .blue       (blue)
  );

  sync_generator sync(
    .vga_clk (vga_clk),
    .reset   (reset),
    .disp_en (disp_en),
    .hsync   (hsync),
    .vsync   (vsync),
    .column  (column),
    .row     (row)
  );

  kb2game keyb(
    board_clk,
    ps2_clk,
    ps2_data,
    p1_control,
    p2_control
  );

  freq_divider #(
    21
  ) freq_21(
    board_clk,
    game_clk
  );

  // clock for game refresh ( ~47 Hz )
  freq_divider #(
    2
  ) freq_2(
    board_clk,
    vga_clk
  );

    // clock for displaying pixels

endmodule

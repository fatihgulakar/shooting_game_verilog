//----------------------------------------------------------------------------------
//-- Interpret the keyboard data for player inputs
//----------------------------------------------------------------------------------

module kb2game(
  input            board_clk,//100MHz
  input            reset,
  input            ps2_clk,
  input            ps2_data,
  output reg [4:0] p1, // 0 to 4 up down left right shoot
  output reg [4:0] p2  // 0 to 4 up down left right shoot
);

  wire clk50;
  reg [7:0]dataprev;
  reg [7:0]dataprev2;
  wire [7:0] data;
  wire valid ; 

  //P1 keys
  localparam P1_u = 8'h1D;  // W
  localparam P1_d = 8'h1B;  // S
  localparam P1_l = 8'h1C;  // A
  localparam P1_r = 8'h23;  // D
  localparam P1_s = 8'h3B;  // J
  //P2 keys
  localparam P2_u = 8'h75;  // ^
  localparam P2_d = 8'h72;  // v
  localparam P2_l = 8'h6B;  // <
  localparam P2_r = 8'h74;  // >
  localparam P2_s = 8'h4C;  // S. l ve i nin ortasi

  freq_divider #(
    .nbits(1)
  ) divider(
    .in_clk  (board_clk),
    .reset   (reset),
    .out_clk (clk50)
  );

  //50 MHz clock
  kb keyboard(
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data),
    .clk(clk50),
    .rx_data(data),
    .valid(valid)
  );


always @(posedge valid or posedge reset)begin
  if (reset) begin
    dataprev2<=1'b0; 
    dataprev <=1'b0;  
    p2 <= 4'h0; 
    p1 <= 4'h0; 
  end else begin
    if (dataprev  == 8'hF0 || dataprev2== 8'hF0 )  begin //key_press_finished (set the corresponding action to 0)
      if (data == 8'hE0) begin
        dataprev2<=dataprev; 
        dataprev <=data;         
      end else begin
        dataprev2<=1'b0; 
        dataprev <=1'b0;       
      end
      case(data)
        P2_u: p2[0] <= 1'b0;
        P2_d: p2[1] <= 1'b0;
        P2_l: p2[2] <= 1'b0;
        P2_r: p2[3] <= 1'b0;
        P2_s: p2[4] <= 1'b0;
        P1_u: p1[0] <= 1'b0;
        P1_d: p1[1] <= 1'b0;
        P1_l: p1[2] <= 1'b0;
        P1_r: p1[3] <= 1'b0;
        P1_s: p1[4] <= 1'b0;      
      endcase           
    end else begin // pressing a key (set the corresponding action to 1)
      dataprev2<=dataprev; 
      dataprev <=data;   
      case(data)
        P2_u: p2[0] <=  1'b1;
        P2_d: p2[1] <=  1'b1;
        P2_l: p2[2] <=  1'b1;
        P2_r: p2[3] <=  1'b1;
        P2_s: p2[4] <=  1'b1;
        P1_u: p1[0] <=  1'b1;
        P1_d: p1[1] <=  1'b1;
        P1_l: p1[2] <=  1'b1;
        P1_r: p1[3] <=  1'b1;
        P1_s: p1[4] <=  1'b1;      
      endcase           
    end
  end    
end


endmodule

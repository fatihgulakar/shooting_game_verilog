module color_generator(
  input        game_clk,//100MHz
  input        reset,
  input        disp_en,
  input [4:0]  p1_control,
  input [4:0]  p2_control,
  input        start,
  input [31:0]  column,
  input [31:0]  row,
  output [2:0] red,
  output [2:0] green,
  output [1:0] blue
);

  // 	--controller commands coming from keyboard
  wire up_1     ;
  wire down_1   ;
  wire left_1   ;
  wire right_1  ;
  wire shoot_1  ;
  
  wire up_2     ;
  wire down_2   ;
  wire left_2   ;
  wire right_2  ;
  wire shoot_2  ;
  
  //	--window frame dimensions
  localparam window_w = 639;
  localparam window_h = 479;

  // pixel enums
  
  //	type state is ( menu_main , menu_win_p1 , menu_win_p2 , game_running );
  //	signal game_state : state := menu_main;
  localparam menu_main = 2'b00;
  localparam menu_win_p1 = 2'b01;
  localparam menu_win_p2 = 2'b10;
  localparam game_running = 2'b11;
  
    reg [1:0] game_state;
    
  //	signal mmenu_en : std_logic := '0';
	//signal menu_p1_en : std_logic := '0';
	//signal menu_p2_en : std_logic := '0';
	
	// velocity of players and bullets
	localparam p_vel = 6;
  localparam b_vel = 15;
	  
	  
	localparam p_w = 40;    // Char width
  localparam p_h = 40;    // Char height
  localparam b_w = 6;     // Bullet width
  localparam b_h = 6;     // Bullet height
  localparam h_w = 15;    // Heart width
  localparam h_h = 15;    // Heart height
  
  
  


//data of player 1
	 reg signed [31:0] p1_x ;//: integer range -p_vel to window_w := window_w-180 ;
	reg signed [31:0]  p1_y ;//: integer range -p_vel to window_h := window_h-80 ;
	reg p1_moving         ;//: std_logic := '0' ;--for collision checks
	wire [1:0] p1_data     ;//: std_logic_vector(1 downto 0);--pixel data taken from object file
	wire p1_en             ;//: std_logic := '0' ;--visibility of p1_data
	reg  [1:0] p1_dir     ; //: integer range 0 to 3 := 0 ;--direction of the character (0-up),(1-down),(2-left),(3-right)
	//health bar of player 1
	reg [1:0] p1_health ; // integer range 0 to 3 := 2; -- health. if it drops to 0 other player wins the game
	wire [1:0] p1_h_en; // : std_logic_vector( 1 downto 0 ) := "11" ;--visibility of health bar
	localparam integer p1_h_x = window_w - 45 ;
	localparam integer p1_h_y = window_h - 25 ;
	wire [1:0]  p1_h_data ;//: std_logic_vector( 1 downto 0 ) := "00" ;--pixel data of health bar
	//data of  player 1 bullet
	reg [9:0] b1_x ;// : integer range -b_vel to window_w := 0 ;
	reg [8:0] b1_y ;//: integer range -b_vel to window_h := 0 ;
	wire b1_data ;//: std_logic := '1';--pixel data taken from object file
	wire b1_en ;//: std_logic := '0' ;--visibility of b1_data
	reg b1_fired ;//: std_logic := '0';
	reg [1:0] b1_dir; // : integer range 0 to 3 := 0 ;--direction of the character (0-up),(1-down),(2-left),(3-right)
	

  	//data of player 2
	reg signed [31:0] p2_x ;//: integer range -p_vel to window_w := 140 ;
	reg signed [31:0] p2_y ;//: integer range -p_vel to window_h := 40 ;
	reg p2_moving         ;//: std_logic := '0' ;--for collision checks
	wire [1:0] p2_data     ;//: std_logic_vector(1 downto 0);--pixel data taken from object file
	wire p2_en             ;//: std_logic := '0' ;--visibility of p1_data
	reg  [1:0] p2_dir     ; //: integer range 0 to 3 := 1 ;--direction of the character (0-up),(1-down),(2-left),(3-right)
	//health bar of player 2
	reg [1:0] p2_health ; // integer range 0 to 3 := 2; -- health. if it drops to 0 other player wins the game
	wire [1:0] p2_h_en; // : std_logic_vector( 1 downto 0 ) := "11" ;--visibility of health bar
	localparam integer p2_h_x = 10 ;
	localparam integer p2_h_y = 10 ;
	wire [1:0]  p2_h_data ;//: std_logic_vector( 1 downto 0 ) := "00" ;--pixel data of health bar
	//data of  player 1 bullet
	reg [9:0] b2_x  ;//: integer range -b_vel to window_w := 0 ;
	reg [8:0] b2_y;// : integer range -b_vel to window_h := 0 ;
	wire b2_data ;//: std_logic := '1';--pixel data taken from object file
	wire b2_en ;//: std_logic := '0' ;--visibility of b1_data
	reg b2_fired ;//: std_logic := '0';
	reg [1:0] b2_dir; // : integer range 0 to 3 := 0 ;--direction of the character (0-up),(1-down),(2-left),(3-right)
	


//type pixel is ( menu_bg , menu_main , menu_p1 , menu_p2 ,
  //game_bg , game_p1 , game_p2 , game_b1 , game_b2,
	//					game_h11 , game_h12 , game_h21 , game_h22 );
	//	signal sel_pix : pixel := menu_bg;--the select signal for choosing the pixel color
  localparam px_menu_bg = 4'd0;
  localparam px_menu_main = 4'd1;
  localparam px_menu_p1 = 4'd2;
  localparam px_menu_p2 = 4'd3;
  localparam px_game_bg = 4'd4;
  localparam px_game_p1 = 4'd5;
  localparam px_game_p2 = 4'd6;
  localparam px_game_b1 = 4'd7;
  localparam px_game_b2 = 4'd8;
  localparam px_game_h11 = 4'd9;
  localparam px_game_h12 = 4'd10;
  localparam px_game_h21 = 4'd11;
  localparam px_game_h22 = 4'd12;
  
  reg [3:0] sel_pix;
  reg [7:0] pix;

  // Color codes
  localparam color_red = 8'hE0;
  localparam color_green = 8'h1C;
  localparam color_blue = 8'h03;
  localparam color_white = 8'hFF;
  localparam color_black = 8'h00;
  localparam color_brown = 8'hB1;
  localparam color_gray = 8'hDB;




  assign up_1     = p1_control[0];
  assign down_1   = p1_control[1];
  assign left_1   = p1_control[2];
  assign right_1  = p1_control[3];
  assign shoot_1  = p1_control[4];
  assign up_2     = p2_control[0];
  assign down_2   = p2_control[1];
  assign left_2   = p2_control[2];
  assign right_2  = p2_control[3];
  assign shoot_2  = p2_control[4];

      

  always@(posedge game_clk or posedge reset) begin
    if(reset) begin
      game_state  <= menu_main;
      p1_moving <= 0;
      p1_dir      <= 0;  
      p1_x        <= window_w-180;
      p1_y        <= window_h-80;
      b1_fired    <= 0;
      b1_dir      <= 0;
      b1_x        <= 0;
      b1_y        <= 0;
      
      p1_health   <= 2;
        
            
      p2_moving <= 0;
      p2_dir      <= 1;
      p2_x        <= 140;
      p2_y        <= 40;
      b2_fired    <= 0;
      b2_dir      <= 0;
      b2_x        <= 0;
      b2_y        <= 0;
      p2_health   <= 2;
    end else begin
      if(game_state == menu_main) begin
        if(start) begin
          game_state <= game_running;
        end
      end

      // game running
      if(game_state == game_running) begin
        // movement of characters
        // p1
        if (up_1) begin
          p1_moving <= 1;
          p1_dir    <= 0; 
          p1_y      <= p1_y - p_vel;
        end else if (down_1) begin
          p1_moving <= 1;
          p1_dir    <= 1;
          p1_y      <= p1_y + p_vel;
        end else if (left_1) begin
          p1_moving <= 1;
          p1_dir    <= 2;
          p1_x      <= p1_x - p_vel;
        end else if (right_1) begin
          p1_moving <= 1;
          p1_dir    <= 3;
          p1_x      <= p1_x + p_vel;
        end else begin
          p1_moving <= 0;
        end
        // p2
        if (up_2) begin
          p2_moving <= 1;
          p2_dir    <= 0;
          p2_y      <= p2_y - p_vel;
        end else if (down_2) begin
          p2_moving <= 1;
          p2_dir    <= 1;
          p2_y      <= p2_y + p_vel;
        end else if (left_2) begin
          p2_moving <= 1;
          p2_dir    <= 2;
          p2_x      <= p2_x - p_vel;
        end else if (right_2) begin
          p2_moving <= 1;
          p2_dir    <= 3;
          p2_x      <= p2_x + p_vel;
        end else begin
          p2_moving <= 0;
        end
        // firing && moving bullets
        // bullet1
        if (shoot_1 && ~b1_fired) begin
          b1_fired <= 1;
          b1_dir <= p1_dir;
          case(b1_dir) 
            0: begin 
              b1_x <= p1_x + 28 ;        
              b1_y <= p1_y;
            end
            1: begin 
              b1_x <= p1_x + 6 ;
              b1_y <= p1_y + p_h;
            end
            2: begin 
              b1_x <= p1_x;
              b1_y <= p1_y + 6;
            end
            default: begin 
              b1_x <= p1_x + p_w - b_w ;
              b1_y <= p1_y + 28;
            end
          endcase
        end else if (b1_fired) begin
          case(b1_dir)
            0: b1_y <= b1_y - b_vel;
            1: b1_y <= b1_y + b_vel;
            2: b1_x <= b1_x - b_vel;
            3: b1_x <= b1_x + b_vel;
          endcase
        end

        // bullet2
        if (shoot_2 && ~b2_fired) begin
          b2_fired <= 1;
          b2_dir <= p2_dir;
          case(b2_dir) 
            0: begin 
              b2_x <= p2_x + 28 ;        
              b2_y <= p2_y;
            end
            1: begin 
              b2_x <= p2_x + 6 ;
              b2_y <= p2_y + p_h;
            end
            2: begin 
              b2_x <= p2_x;
              b2_y <= p2_y + 6;
            end
            default: begin 
              b2_x <= p2_x + p_w - b_w ;
              b2_y <= p2_y + 28;
            end
          endcase
        end else if (b2_fired) begin
          case(b2_dir)
            0: b2_y <= b2_y - b_vel;
            1: b2_y <= b2_y + b_vel;
            2: b2_x <= b2_x - b_vel;
            3: b2_x <= b2_x + b_vel;
          endcase
        end

        // collision checks
        // bullet 1 at edges of the window
        if (((b1_x <= 0) || (b1_x >= window_w - b_w)) || ((b1_y <= 0) || (b1_y >= window_h - b_h))) begin
          b1_fired <= 0;
        end
        // bullet 2 at edges of the window
        if ( ( (b2_x <= 0) || (b2_x >= window_w - b_w) ) || ( (b2_y <= 0) || (b2_y >= window_h - b_h) ) ) begin
          b2_fired <= 0;
        end

        // bullet 1 with player 2
        if ((((b1_x < p2_x &&  b1_x + b_w > p2_x) || (p2_x < b1_x &&  p2_x + p_w > b1_x)) &&
              ((b1_y < p2_y &&  b1_y + b_h > p2_y) || (p2_y < b1_y &&  p2_y + p_h > b1_y))
            ) && b1_fired ) begin
          p2_health <= p2_health - 1;
          b1_fired <= 0;
        end
        // bullet 2 with player 1
        if ((((b2_x < p1_x &&  b2_x + b_w > p1_x) || (p1_x < b2_x &&  p1_x + p_w > b2_x)) &&
              ((b2_y < p1_y &&  b2_y + b_h > p1_y) || (p1_y < b2_y &&  p1_y + p_h > b2_y))
            ) && b2_fired ) begin
          p1_health <= p1_health - 1;
          b2_fired <= 0;
        end

        // player 1 with player 2
        if (((p1_x < p2_x+2 && p1_x + p_w > p2_x) || (p2_x < p1_x+2 && p2_x + p_w > p1_x)) &&
            ((p1_y < p2_y+2 && p1_y + p_h > p2_y) || (p2_y < p1_y+2 && p2_y + p_h > p1_y))) begin
          if (p1_moving) begin
            case(p1_dir)
              0: p2_y <= p2_y - p_vel;
              1: p2_y <= p2_y + p_vel;
              2: p2_x <= p2_x - p_vel;
              3: p2_x <= p2_x + p_vel;
            endcase
          end
          if (p2_moving) begin
            case(p2_dir)
              0: p1_y <= p1_y - p_vel;
              1: p1_y <= p1_y + p_vel;
              2: p1_x <= p1_x - p_vel;
              3: p1_x <= p1_x + p_vel;
            endcase
          end
        end

        // player 1 at edges of the window
        if(p1_x < 0) begin 
          p1_x <= 3;
        end
        if(p1_x > window_w - p_w) begin 
          p1_x <= window_w - p_w ;
        end
        if(p1_y < 0) begin 
          p1_y <= 3 ;
        end
        if(p1_y > window_h - p_h) begin 
          p1_y <= window_h - p_h;
        end

        // player 2 at edges of the window
        if(p2_x < 0) begin 
          p2_x <= 3;
        end
        if(p2_x > window_w - p_w) begin 
          p2_x <= window_w - p_w ;
        end
        if(p2_y < 0) begin 
          p2_y <= 3 ;
        end
        if(p2_y > window_h - p_h) begin 
          p2_y <= window_h - p_h;
        end

        // game over conditions check
        if(p1_health == 0) begin
          game_state <= menu_win_p2;
        end
        if(p2_health == 0) begin
          game_state <= menu_win_p1;
        end
      end
    end
  end

  //Visibility of players && their bullets
	assign p1_en = ((column >= p1_x) && (column < p1_x + p_w)) && ((row >= p1_y) && (row < p1_y + p_h));
	assign b1_en = ((column >= b1_x) && (column < b1_x + b_w)) && ((row >= b1_y) && (row < b1_y + b_h)) && b1_fired;
	assign p2_en = ((column >= p2_x) && (column < p2_x + p_w)) && ((row >= p2_y) && (row < p2_y + p_h));
	assign b2_en = ((column >= b2_x) && (column < b2_x + b_w)) && ((row >= b2_y) && (row < b2_y + b_h)) && b2_fired;

  // Pixel data
  wire [31:0] obj_p1_x;
  wire [31:0] obj_b1_x;
  wire [31:0] obj_b2_x;
  wire [31:0] obj_p1_y;
  wire [31:0] obj_b2_y;
  wire [31:0] obj_b1_y;
  wire [31:0] obj_p2_x;
  wire [31:0] obj_p2_y;
  
  assign obj_p1_x = column - p1_x;
  assign obj_p2_x = column - p2_x;
  assign obj_b1_x = column - b1_x;
  assign obj_b2_x = column - b2_x;
  assign obj_p1_y = row - p1_y;
  assign obj_p2_y = row - p2_y;
  assign obj_b1_y = row - b1_y;
  assign obj_b2_y = row - b2_y;
  obj_p obj_p1(.x(obj_p1_x[5:0]), .y(obj_p1_y[5:0]), .dir(p1_dir), .en(p1_en), .data(p1_data));
  obj_b obj_b1(.x(obj_p1_y[2:0]), .y(obj_b1_y[2:0]) ,  .en(b1_en), .data(b1_data));
  obj_p obj_p2(.x(obj_p2_x[5:0]), .y(obj_p2_y[5:0]), .dir(p2_dir), .en(p2_en), .data(p2_data));
  obj_b obj_b2(.x(obj_b2_x[2:0]), .y(obj_b2_y[2:0]),  .en(b2_en), .data(b2_data));

  // Visibility of health bars
  assign p1_h_en[0] = ((column >= p1_h_x) && (column < p1_h_x + h_w)) && ((row >= p1_h_y) && (row < p1_h_y + h_h)) && p1_health > 0;
  assign p1_h_en[1] = ((column >= p1_h_x + h_w+5) && (column < p1_h_x + 2*h_w+5)) && ((row >= p1_h_y) && (row < p1_h_y + h_h)) && p1_health > 1;

  assign p2_h_en[0] = ((column >= p2_h_x) && (column < p2_h_x + h_w)) && ((row >= p2_h_y) && (row < p2_h_y + h_h)) && p2_health > 0;
  assign p2_h_en[1] = ((column >= p2_h_x + h_w+5) && (column < p2_h_x + 2*h_w+5)) && ((row >= p2_h_y) && (row < p2_h_y + h_h)) && p2_health > 1;

  wire [31:0]  obj_h11_x;
  wire [31:0]  obj_h12_x;
  wire [31:0]  obj_h22_x;
  wire [31:0]  obj_h21_x;
  wire [31:0]  obj_h11_y;
  wire [31:0]  obj_h12_y;
  wire [31:0]  obj_h22_y;
  wire [31:0]  obj_h21_y;
  
  assign  obj_h11_x = column-p1_h_x;
  assign  obj_h12_x = column-(p1_h_x+h_w+5);
  assign  obj_h22_x = column-(p2_h_x+h_w+5);
  assign  obj_h21_x = column-p2_h_x;
  assign  obj_h11_y = row-p1_h_y;
  assign  obj_h12_y = row-p1_h_y;
  assign  obj_h22_y = row-p2_h_y;
  assign  obj_h21_y = row-p2_h_y;
   
  
  obj_heart obj_h11(.x(obj_h11_x[3:0]), .y(obj_h11_y[3:0]), .en(p1_h_en[0]), .data(p1_h_data[0]));
  obj_heart obj_h12(.x(obj_h12_x[3:0]), .y(obj_h12_y[3:0]), .en(p1_h_en[1]), .data(p1_h_data[1]));
  obj_heart obj_h21(.x(obj_h21_x[3:0]), .y(obj_h22_y[3:0]), .en(p2_h_en[0]), .data(p2_h_data[0]));
  obj_heart obj_h22(.x(obj_h22_x[3:0]), .y(obj_h21_y[3:0]), .en(p2_h_en[1]), .data(p2_h_data[1]));

  always@(*) begin
    //sel_pix = 0;
    if(game_state == menu_win_p1 )begin
      sel_pix = px_menu_p1 ;
    end else if (game_state == menu_win_p2) begin
      sel_pix = px_menu_p2;
    end else if(game_state == game_running) begin
      if(p1_en) sel_pix = px_game_p1;
      else if(p2_en) sel_pix = px_game_p2;
      else if(b1_en) sel_pix = px_game_b1;
      else if(b2_en) sel_pix = px_game_b2;
      else if(p1_h_en[0]) sel_pix = px_game_h11;
      else if(p1_h_en[1]) sel_pix = px_game_h12;
      else if(p2_h_en[0]) sel_pix = px_game_h21;
      else if(p2_h_en[1]) sel_pix = px_game_h22;
      else sel_pix = px_game_bg;
    end else begin //menu_main
      sel_pix = px_menu_main ;
    end
  end

  always @(*) begin
    case(sel_pix)
      // menu
      px_menu_main: pix = color_green;
      px_menu_p1: pix = color_blue;
      px_menu_p2: pix = color_red;
      // health bars
      px_game_h11: pix = p1_h_data[0] ? color_red : color_gray;
      px_game_h12: pix = p1_h_data[1] ? color_red : color_gray;
      px_game_h21: pix = p2_h_data[0] ? color_red : color_gray;
      px_game_h22: pix = p2_h_data[1] ? color_red : color_gray;
      // players
      px_game_p1: begin
        case(p1_data)
          2'b00: pix = color_gray;    // background
          2'b01: pix = color_blue;    // head color
          2'b10: pix = color_black;   // border lines
          2'b11: pix = color_brown;   // gund and backpack color
        endcase
      end
      px_game_p2: begin
        case(p2_data)
          2'b00: pix = color_gray;    // background
          2'b01: pix = color_green;    // head color
          2'b10: pix = color_black;   // border lines
          2'b11: pix = color_red;   // gund and backpack color
        endcase
      end
      // bullets
      px_game_b1: pix = b1_data ? color_blue : color_gray;
      px_game_b2: pix = b2_data ? color_black  :color_gray;
      // background
      px_game_bg: pix = color_gray;
      default: pix = color_gray;
    endcase
  end

  assign red = disp_en   ? pix[7:5] : 3'b000;
  assign green = disp_en ? pix[4:2] : 3'b000;
  assign blue = disp_en  ? pix[1:0] : 3'b000;

endmodule
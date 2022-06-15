//----------------------------------------------------------------------------------
//-- Reads keyboard data
//----------------------------------------------------------------------------------


module kb(
    input ps2_clk,
    input ps2_data,
    input clk, // 50 mhz
    output  [7:0] rx_data,
    output        valid //valid at rising edge
);
    
    
    wire kclkf, kdataf;
    reg [7:0]datacur;
    reg [3:0]cnt;
    reg [31:0]keycode;
    reg flag;
    
    initial begin
        keycode[31:0]<=31'h00000000;
        cnt<=4'b0000;
        flag<=1'b0;
    end
    
debouncer debounce(
    .clk(clk),
    .I0(ps2_clk),
    .I1(ps2_data),
    .O0(kclkf),
    .O1(kdataf)
);
    
always@(negedge(kclkf))begin
    case(cnt)
    0:;//Start bit
    1:datacur[0]<=kdataf;
    2:datacur[1]<=kdataf;
    3:datacur[2]<=kdataf;
    4:datacur[3]<=kdataf;
    5:datacur[4]<=kdataf;
    6:datacur[5]<=kdataf;
    7:datacur[6]<=kdataf;
    8:datacur[7]<=kdataf;
    9:flag<=1'b1;
    10:flag<=1'b0;
    
    endcase
        if(cnt<=9) cnt<=cnt+1;
        else if(cnt==10) cnt<=0;
        
end

assign rx_data = datacur;  
assign valid = flag;  



endmodule

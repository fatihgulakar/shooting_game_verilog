//bullets of characters
//----------------------------------------------------------------------------------


module obj_b (
    input [2:0] x,
    input [2:0] y,
    input       en,
    output      data
);

reg rom [0:5][0:5];

initial begin
	rom[0] = {1'b0,1'b0,1'b1,1'b1,1'b0,1'b0};
	rom[1] = {1'b0,1'b1,1'b1,1'b1,1'b1,1'b0};
	rom[2] = {1'b1,1'b1,1'b1,1'b1,1'b1,1'b1};
	rom[3] = {1'b1,1'b1,1'b1,1'b1,1'b1,1'b1};
	rom[4] = {1'b0,1'b1,1'b1,1'b1,1'b1,1'b0};
	rom[5] = {1'b0,1'b0,1'b1,1'b1,1'b0,1'b0};
end
 
assign data = en ? rom[y][x] : 1'b0;


endmodule
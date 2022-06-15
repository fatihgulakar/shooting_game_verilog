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
 rom[0][0] = 1'b0;	 rom[1][0] = 1'b0;	 rom[2][0] = 1'b1;	 rom[3][0] = 1'b1;	 rom[4][0] = 1'b0;	 rom[5][0] = 1'b0;
 rom[0][1] = 1'b0;	 rom[1][1] = 1'b1;	 rom[2][1] = 1'b1;	 rom[3][1] = 1'b1;	 rom[4][1] = 1'b1;	 rom[5][1] = 1'b0;
 rom[0][2] = 1'b1;	 rom[1][2] = 1'b1;	 rom[2][2] = 1'b1;	 rom[3][2] = 1'b1;	 rom[4][2] = 1'b1;	 rom[5][2] = 1'b1;
 rom[0][3] = 1'b1;	 rom[1][3] = 1'b1;	 rom[2][3] = 1'b1;	 rom[3][3] = 1'b1;	 rom[4][3] = 1'b1;	 rom[5][3] = 1'b1;
 rom[0][4] = 1'b0;	 rom[1][4] = 1'b1;	 rom[2][4] = 1'b1;	 rom[3][4] = 1'b1;	 rom[4][4] = 1'b1;	 rom[5][4] = 1'b0;
 rom[0][5] = 1'b0;	 rom[1][5] = 1'b0;	 rom[2][5] = 1'b1;	 rom[3][5] = 1'b1;	 rom[4][5] = 1'b0;	 rom[5][5] = 1'b0;
/*
	rom[0] = {1'b0,1'b0,1'b1,1'b1,1'b0,1'b0};
	rom[1] = {1'b0,1'b1,1'b1,1'b1,1'b1,1'b0};
	rom[2] = {1'b1,1'b1,1'b1,1'b1,1'b1,1'b1};
	rom[3] = {1'b1,1'b1,1'b1,1'b1,1'b1,1'b1};
	rom[4] = {1'b0,1'b1,1'b1,1'b1,1'b1,1'b0};
	rom[5] = {1'b0,1'b0,1'b1,1'b1,1'b0,1'b0};*/
end

assign data = en ? rom[y][x] : 1'b0;


endmodule
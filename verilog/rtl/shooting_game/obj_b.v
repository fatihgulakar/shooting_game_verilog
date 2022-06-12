module obj_b(
    input [2:0] x,
    input [2:0] y,
    input       en,
    output      data
);



wire rom [0:5][0:5] = {{1'b0,1'b0,1'b1,1'b1,1'b0,1'b0},
					   {1'b0,1'b1,1'b1,1'b1,1'b1,1'b0},
					   {1'b1,1'b1,1'b1,1'b1,1'b1,1'b1},
					   {1'b1,1'b1,1'b1,1'b1,1'b1,1'b1},
					   {1'b0,1'b1,1'b1,1'b1,1'b1,1'b0},
				       {1'b0,1'b0,1'b1,1'b1,1'b0,1'b0}};

data = en ? rom[y][x] : 1'b0;


endmodule
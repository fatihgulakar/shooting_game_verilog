//bullets of characters
//----------------------------------------------------------------------------------


module obj_b #(
localparam    rom_b [0:5][0:5] = {'{1'b0,1'b0,1'b1,1'b1,1'b0,1'b0},
                                  '{1'b0,1'b1,1'b1,1'b1,1'b1,1'b0},
                                  '{1'b1,1'b1,1'b1,1'b1,1'b1,1'b1},
                                  '{1'b1,1'b1,1'b1,1'b1,1'b1,1'b1},
                                  '{1'b0,1'b1,1'b1,1'b1,1'b1,1'b0},
                                  '{1'b0,1'b0,1'b1,1'b1,1'b0,1'b0}}
)(
    input [2:0] x,
    input [2:0] y,
    input       en,
    output      data
);

reg rom [0:5][0:5];


  // rows 1st columns second
 
 /* 
*/
//assign ata = en ? rom_b[y][x] : 1'b0;


endmodule
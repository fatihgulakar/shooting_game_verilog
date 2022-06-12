module kb(
    input ps2_clk,
    input ps2_data,
    input clk, // 50 mhz
    output [7:0] data,
    output       data_break
);
    wire ps2_clk_n;
    wire ps2_data_n;
    reg [10:0] temp;
    reg e, e_old;


    // TODO: Add ps2 stuff here

    assign e = (i == 10) ? ~(temp[10] && ~temp[0] && (^temp[9:1])) : 1'b1;

    assign new_data = (e ^ e_old) && (~e);

    always@(posedge clk) begin
        e_old <= e;
        if(new_data) begin
            data1 <= temp[8:1];
            data2 <= data1;
            data3 <= data2;
        end

        if(chk_data) begin
            data_break <= 1'b0;
            data <= 0;
            chk_data <= 0;
        end

        if(e == 0) begin
            if(~(data1 == 8'hF0 || data1 == 8'hE0)) begin
                chk_data <= 1'b1;
                data <= data1;
                if(data2 == 8'hF0) begin
                    data_break <= 1'b1;
                end
            end else begin
                chk_data <= 1'b0;
            end
        end
    end


endmodule
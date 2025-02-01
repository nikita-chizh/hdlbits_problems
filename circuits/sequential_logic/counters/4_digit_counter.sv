module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    logic [3:0] plus_one;
    assign plus_one[0] = 1'b1;
    always_comb begin : kek
        for (integer i = 1; i <= 3; i += 1)
        begin
            if (q[(i-1)*4 +: 4] == 9 & plus_one[i-1]==1)
            begin
                plus_one[i] = 1;
                ena[i] = 1;
            end
            else
            begin
                plus_one[i] = 0;
                ena[i] = 0;
            end
        end
    end

    always_ff @( posedge clk ) begin : blockName
        if (reset)
            begin
                q <= 0;
                // ena <= 0;
            end
        else
            begin
                if (q[3:0] == 9)
                    q[3:0] <= 0;
                else
                    q[3:0] <= q[3:0] + 1;

                for(integer i = 1; i <= 3; i += 1)
                    if (q[i*4 +: 4] == 9 & plus_one[i] == 1)
                    begin
                        q[i*4 +: 4] <= 0;
                    end
                    else
                    begin
                        q[i*4 +: 4] <= q[i*4 +: 4] + plus_one[i];
                    end
            end
    end
    //assign ena[1] = q[7:4] == 9 & plus_one[1]==1;
    //assign ena[2] = q[11:8] == 9 & plus_one[2]==1;
    //assign ena[3] = q[15:12] == 9 & plus_one[3]==1;

endmodule

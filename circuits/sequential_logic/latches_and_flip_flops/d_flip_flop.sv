module top_module (
    input clk,
    input d,
    output reg q );

    always_ff @(posedge clk)
        q <= d;


endmodule

module top_module (
    input clk,
    input [7:0] d,
    output [7:0] q
);
    always_ff @(posedge clk)
        q <= d;

endmodule

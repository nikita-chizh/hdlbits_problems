module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output [7:0] q
);
    always_ff @( negedge clk)
        if (reset)
            q <= 8'h34;
        else
            q <= d;

endmodule

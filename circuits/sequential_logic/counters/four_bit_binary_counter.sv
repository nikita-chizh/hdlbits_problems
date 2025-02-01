module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);


    always_ff @(posedge clk)
        if (reset | q == 16)
            q <= 0;
        else
            q <= q + 1;
endmodule

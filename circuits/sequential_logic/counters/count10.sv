module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);

    // period is 10 not inclusive !!!
    always_ff @(posedge clk)
        if (reset | q == 9)
            q <= 0;
        else
            q <= q + 1;
endmodule

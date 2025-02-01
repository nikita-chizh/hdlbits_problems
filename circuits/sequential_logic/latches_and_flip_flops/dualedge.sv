 module top_module (
    input clk,
    input d,
    output q
);
    reg neg, pos;

    always_ff @(posedge clk)
        pos <= d;

    always_ff @(negedge clk)
        neg <= d;

    assign q = clk ? pos : neg;

endmodule

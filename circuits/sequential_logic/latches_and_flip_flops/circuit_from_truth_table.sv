module top_module (
    input clk,
    input j,
    input k,
    output Q); 

    wire q_old;
    assign q_old = Q;
    always_ff @(posedge clk) begin
        if (~j & ~k)
            Q <= q_old;
        else if (~j & k)
            Q <= 0;
        else if (j & ~k)
            Q <= 1;
        else if (j & k)
            Q <= ~q_old;
    end
endmodule

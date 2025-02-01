module top_module (
    input clk,
    input d, 
    input r,   // asynchronous reset
    output q);

    always_ff @( posedge clk)
        if (r)
            q <= 0;
        else
            q <= d;

endmodule

nikitos228
2112916wq

module top_module (
    input clk,
    input in, 
    output out);
    wire d;
    assign d = in ^ out;
    always_ff @(posedge clk)
        out <= d;
endmodule

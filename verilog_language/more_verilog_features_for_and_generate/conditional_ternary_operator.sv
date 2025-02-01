module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//

    wire [7:0] ab = a < b ? a : b;
    wire [7:0] cd = c < d ? c : d;
    assign min = ab < cd ? ab : cd;
endmodule

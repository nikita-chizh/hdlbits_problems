module top_module (input [31:0] a, input [31:0] b, input sub, output [31:0] sum);
    wire [31:0] reverted_b;
    assign reverted_b = b ^ {32{sub}};
    //
    wire [15:0] lower_a = a[15:0];
    wire [15:0] lower_b = reverted_b[15:0];
    wire [15:0] lower_sum;
    wire cout_lower;
    add16 low_add( lower_a, lower_b, sub, lower_sum, cout_lower);
    //
    wire [15:0] higher_a = a[31:16];
    wire [15:0] higher_b = reverted_b[31:16];
    wire [15:0] higher_sum;
    wire cout_higher;
    add16 higher_add( higher_a, higher_b, cout_lower, higher_sum, cout_higher);
    assign sum = {higher_sum, lower_sum};
endmodule

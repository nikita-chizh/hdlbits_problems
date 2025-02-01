module top_module(input [31:0] a, input [31:0] b, output [31:0] sum);
    wire [15:0] lower_a = a[15:0];
    wire [15:0] lower_b = b[15:0];
    wire [15:0] lower_sum;
    wire cin_lower;
    wire cout_lower;
    add16 low_add( lower_a, lower_b, cin_lower, lower_sum, cout_lower);
    //
    wire [15:0] higher_a = a[31:16];
    wire [15:0] higher_b = b[31:16];
    wire [15:0] higher_sum;
    wire cout_higher;
    add16 higher_add( higher_a, higher_b, cout_lower, higher_sum, cout_higher);
    assign sum = {higher_sum, lower_sum};
endmodule

module top_module(input [31:0] a, input [31:0] b, output [31:0] sum);
    wire [15:0] lower_a = a[15:0];
    wire [15:0] lower_b = b[15:0];
    wire [15:0] lower_sum;
    wire cin_lower;
    wire cout_lower;
    add16 low_add( lower_a, lower_b, cin_lower, lower_sum, cout_lower);
    // two upper adders
    wire [15:0] higher_a = a[31:16];
    wire [15:0] higher_b = b[31:16];
    wire [15:0] higher_sum_0, higher_sum_1;
    wire cout_lower_0, cout_lower_1;
    wire cout_higher;
    assign cout_lower_0 = 1'b0;
    assign cout_lower_1 = 1'b1;
    add16 higher_add_0( higher_a, higher_b, cout_lower_0, higher_sum_0, cout_higher);
    add16 higher_add_1( higher_a, higher_b, cout_lower_1, higher_sum_1, cout_higher);
    // res
    always @*
    begin
        if (cout_lower == 2'd0)
        begin
            sum <= {higher_sum_0, lower_sum};
        end
        else
        begin
            sum <= {higher_sum_1, lower_sum};
        end
    end

endmodule

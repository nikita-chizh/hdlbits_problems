module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );
    logic [99:0] cout_;
    generate
        full_adder adder0 (a[0], b[0], cin, sum[0], cout_[0]);
        genvar i;
        for (i = 1; i < 100; i += 1)
        begin : add
            full_adder adder (a[i], b[i], cout_[i-1], sum[i], cout_[i]);
        end
    endgenerate
    assign cout = cout_[99];
endmodule


module full_adder(input a, b, cin, output sum, cout);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a^b) );
endmodule

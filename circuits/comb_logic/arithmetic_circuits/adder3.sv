module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );

    generate
        full_adder adder0 (a[0], b[0], cin, cout[0], sum[0]);
        genvar i;
        for (i = 1; i < 3; i += 1)
        begin : add
            full_adder adder (a[i], b[i], cout[i-1], cout[i], sum[i]);
        end
    endgenerate

endmodule


module full_adder( 
    input a, b, cin,
    output cout, sum );
    assign cout = (a & b) | (a & cin) | (b & cin);
    assign sum = a ^ b ^ cin; 

endmodule

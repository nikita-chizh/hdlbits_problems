module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );

    wire[99:0] cout_arr;
    generate
        bcd_fadd  adder0 (a[3:0], b[3:0], cin, cout_arr[0], sum[3:0]);
        genvar i;
        for (i = 4; i < 400; i += 4)
        begin : add
            bcd_fadd adder (a[i+3:i], b[i+3:i], cout_arr[i/4-1], cout_arr[i/4], sum[i+3:i]);
        end
    endgenerate
    assign cout = cout_arr[99];
endmodule

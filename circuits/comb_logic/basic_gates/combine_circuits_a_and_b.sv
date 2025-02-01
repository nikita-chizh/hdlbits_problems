module top_module (input x, input y, output z);
    wire a1_res, a2_res, b1_res, b2_res;
    mod_a a1(x, y, a1_res);
    mod_a a2(x, y, a2_res);
    mod_b b1(x, y, b1_res);
    mod_b b2(x, y, b2_res);
    assign z = (a1_res | b1_res) ^ (a2_res & b2_res);
endmodule


module mod_a (input x, input y, output z);
    assign z = (x^y) & x;
endmodule

module mod_b ( input x, input y, output z );
    assign z = ~(x^y);
endmodule

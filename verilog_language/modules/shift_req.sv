module top_module ( input clk, input d, output q );
    wire q0, q1, q2;
    my_dff r0(clk, d, q0);
    my_dff r1(clk, q0, q1);
    my_dff r2(clk, q1, q2);
    // no need for always, since my_dff is always a sequential scheme
    /*
    always @(posedge clk)
    begin
        // q0 <= d;
    end
    */
    assign q = q2;

endmodule

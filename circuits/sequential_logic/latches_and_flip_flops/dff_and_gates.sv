module top_module (
    input clk,
    input x,
    output z
); 
    wire q0, q1, q2;
    always_ff @( posedge clk ) begin : fsm
        q0 <= x ^ q0;
        q1 <= x & ~q1;
        q2 <= x | ~q2;
    end
    assign z = ~(q0 | q1 | q2);
endmodule

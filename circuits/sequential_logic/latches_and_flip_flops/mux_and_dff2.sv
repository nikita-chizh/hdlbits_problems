module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    wire first_mux;
    assign first_mux = E ? w : Q;
    wire d;
    assign d = L ? R : first_mux;
    always_ff @(posedge clk)
        Q <= d;

endmodule

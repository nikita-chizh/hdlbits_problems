module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);

    always_ff @(posedge clk)
        if (L)
            Q <= r_in;
        else
            Q <= q_in;


endmodule

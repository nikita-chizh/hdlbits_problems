module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q); 

    always_ff @( posedge clk) begin : shift_reg
        if (load)
            q <= data;
        else if (ena == 2'b01) // right
            q <= {q[0], q[99:1]};
        else if (ena == 2'b10) // left
            q <= {q[98:0], q[99]};
        // else if (ena == 2'b00)
        //     q <= {1'b0, q[98:1]};
        // else if (ena == 2'b11)
        //     q <= {q[98:1], 1'b0};
    end



endmodule

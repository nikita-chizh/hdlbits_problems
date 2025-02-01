module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);
    always_ff @( posedge clk)
    begin
        if (~resetn) // active-low reset
        begin
            q <= 0;
        end
        else
        begin
            if (byteena == 2'b11)
                q <= d;
            else if (byteena == 2'b01)
                q[7:0] <= d[7:0];
            else if (byteena == 2'b10)
                q[15:8] <= d[15:8];
        end
    end

endmodule

module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    wire [7:0] old_values; // could be reg, but no necessarily 
    always_ff @(posedge clk)
    begin
        old_values <= in;
        for (integer i = 0; i < 8; i += 1)
            anyedge[i] <= old_values[i] != in[i];
    end

endmodule


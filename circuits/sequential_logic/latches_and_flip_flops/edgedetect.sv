module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    wire [7:0] old_values; // could be reg, but no necessarily 
    always_ff @(posedge clk)
    begin
        old_values <= in;
        for (integer i = 0; i < 8; i += 1)
        begin
            if (~old_values[i] & in[i])
                pedge[i] <= 1;
            else
                pedge[i] <= 0;
        end
    end

endmodule


module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);

    wire [31:0] old_values;
    reg [31:0] state;
    always_ff @(posedge clk)
    begin
        old_values <= in;
        if (reset)
        begin
            state <= 0;
        end
        else
            for (integer i = 0; i < 32; i += 1)
            begin
                if (state[i] != 1)
                begin
                    state[i] = old_values[i] & ~in[i];
                end
            end
    end
    assign out = state;

endmodule

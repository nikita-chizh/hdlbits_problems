module top_module(input clk, input [7:0] in, input reset, output done);
    enum bit[2:0] {WAIT, ACCEPT, DONE} PARCIING_STATE;
    logic[2:0] state, next_state;
    logic [2:0] c;

    always @(*) begin
        if (state == WAIT)
            next_state = (in[3] == 1) ? ACCEPT : WAIT; 
        else if (state == ACCEPT)
            next_state = (c == 2) ? DONE : ACCEPT;
        else if (state == DONE)
            next_state = (in[3] == 1) ? ACCEPT : WAIT;
    end

    always_ff @(posedge clk)
    begin
        if (reset)
        begin
            state <= WAIT;
            c <= 0;
        end
        else
        begin
            state <= next_state;
            if (next_state == ACCEPT)
                c <= c + 1;
            else
                c <= 0;
        end
    end
    assign done = (state == DONE);
endmodule

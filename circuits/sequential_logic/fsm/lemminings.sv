module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    parameter LEFT=0, RIGHT=1;
    reg state, next_state;

    always_comb begin : state_trans
        if (walk_left && bump_left)
            next_state = RIGHT;
        else if (walk_right && bump_right)
            next_state = LEFT;
        else
            next_state = state;
    end

    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end
    
    // Output logic
    assign walk_left = state == LEFT ? 1 : 0;
    assign walk_right = state == RIGHT ? 1 : 0;

endmodule

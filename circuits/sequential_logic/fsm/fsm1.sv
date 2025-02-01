module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin    // This is a combinational always block
        if (in == 0)
            next_state = state == A ? B : A;
        else
            next_state = state;
    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        if (areset)
            state <= B;
        else
            state <= next_state;
    end

    assign out = state;

endmodule

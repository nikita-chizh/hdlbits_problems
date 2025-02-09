`timescale 1ns / 1ps
// module top_module
module fsm_ps2data( input clk, input [7:0] in, input reset
                    , output [23:0] out_bytes, output done);
    localparam WIDTH = 8;
    localparam INIT_POINTER = 3;
    enum {WAIT, ACCEPT, DONE} PARCIING_STATE;
    logic [23:0] buffer;
    integer buffer_pointer = INIT_POINTER;
    logic [1:0] state = WAIT;
    logic [1:0] next_state = WAIT;
    always @(*) begin
        if (state == WAIT)
        begin
            next_state = (in[3] == 1) ? ACCEPT : WAIT; 
        end
        else if (state == ACCEPT)
        begin
            next_state = (buffer_pointer == 1) ? DONE : ACCEPT;
        end
        else if (state == DONE)
        begin
            next_state = (in[3] == 1) ? ACCEPT : WAIT;
        end
    end

    always_ff @(posedge clk) begin
        if (reset)
        begin
            buffer <= 0;
            buffer_pointer <= INIT_POINTER;
            state <= WAIT;
        end else
        begin
            state <= next_state;
            if (next_state == ACCEPT | state == ACCEPT)
            begin
                buffer[ (buffer_pointer * WIDTH) - 1 -: WIDTH] <= in;
                if (state == DONE)
                    buffer[15:0] <= 0;
                buffer_pointer <= buffer_pointer == 1 ? INIT_POINTER : buffer_pointer - 1;
            end
            else
            begin
                buffer_pointer <= INIT_POINTER;
                buffer <= 0;
            end
        end
    end
    assign done = (state == DONE);
    assign out_bytes = buffer;
endmodule

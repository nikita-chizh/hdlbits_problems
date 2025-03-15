`timescale 1ns / 1ps


module only_one_button
# (parameter NUMBER_OF_BUTTONS)
(input wire clk, input wire rst, input logic[NUMBER_OF_BUTTONS-1:0] buttons, output logic pressed_one);

    enum {IDLE, BLOCKED, WAITING} STATE;

    logic[NUMBER_OF_BUTTONS-1:0] stored_buttons = '0;
    logic[1:0] state = IDLE;
    logic[1:0] next_state = IDLE;
    logic pressed = 0;

    always_comb begin : state_trans
        if (state == IDLE) begin
            if (buttons == '0) // empty vector
                next_state = IDLE;
            else if ($countones(buttons) == 1)
                next_state = WAITING;
            else
                next_state = BLOCKED;
        end
        else if (state == BLOCKED) begin
            if (buttons == 0)
                next_state = IDLE;
            else
                next_state = BLOCKED;
        end
        else begin // state == WAITING
            if (buttons == 0)
                next_state = IDLE;
            else begin
                if (buttons == stored_buttons)
                    next_state = WAITING;
                else
                    next_state = BLOCKED;
            end
        end
    end

    always_ff @( posedge clk) begin
        if (rst) begin
            stored_buttons <= 0;
            state <= IDLE;
            pressed <= 0;
        end else begin
            if (state == WAITING & next_state == IDLE)
                pressed <= 1;
            else
                pressed <= 0;
            state <= next_state;
            stored_buttons <= buttons;
        end
    end
    assign pressed_one = pressed;

endmodule

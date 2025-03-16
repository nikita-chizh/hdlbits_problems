`timescale 1ns / 1ps


module button_debouncing
# (parameter NUMBER_OF_CYCLES = 10)
( input logic clk, input logic rst, input logic button, output logic debounced);
    
    (* mark_debug = "true" *) logic[31:0] counter = 0;
    (* mark_debug = "true" *) logic button_prev = 0;
    always @( posedge clk)
    begin
        if (rst) begin
            counter <= 0;
            button_prev <= 0;
        end
        else begin
            if (button == button_prev)
                counter <= counter != NUMBER_OF_CYCLES ? counter <= counter + 1 : counter;
            else
                counter <= 0;
            button_prev <= button;
        end   
    end
    assign debounced = {counter == NUMBER_OF_CYCLES};
    
endmodule
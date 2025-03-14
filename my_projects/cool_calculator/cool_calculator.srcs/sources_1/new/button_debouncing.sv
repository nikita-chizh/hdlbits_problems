`timescale 1ns / 1ps


module button_debouncing
# (parameter NUMBER_OF_CYCLES)
( input wire clk, input wire rst, input wire button, output logic debounced);
    
    logic [$clog2(NUMBER_OF_CYCLES)-1:0] counter = '0;
    logic button_prev = 0;
    logic debounce_happened = 0;
    // initial begin
    //     counter = '0;
    //     button_prev = 0;
    //     debounce_happened = 0;
    // end
    always_ff @( posedge clk)
    begin
        if (rst) begin
            counter <= 0;
            button_prev <= 0;
            debounce_happened <= 0;
        end
        else begin
            if (button == button_prev) begin
                if (counter == NUMBER_OF_CYCLES) begin
                    debounce_happened <= 1;
                    counter <= 0;
                end else
                    counter <= counter + 1;
            end
            else begin
                counter <= 0;
                debounce_happened <= 0;
            end
            button_prev <= button;
        end   
    end
    assign debounced = debounce_happened;
endmodule

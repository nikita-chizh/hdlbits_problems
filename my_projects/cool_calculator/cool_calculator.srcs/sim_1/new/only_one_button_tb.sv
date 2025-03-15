`timescale 1ns / 1ps


module only_one_button_tb();
    parameter NUMBER_OF_BUTTONS = 4;

    logic clk = 0;
    logic rst = 0;
    logic[NUMBER_OF_BUTTONS-1:0] buttons = '0;
    logic pressed_one = 0;

    only_one_button #(NUMBER_OF_BUTTONS) uut (.*);

    always #5 clk = ~clk;
    initial begin
        #10 buttons = 4'b0001;
        #30 buttons = 4'b0000;
        #10 buttons = 4'b0001;
        #20 buttons = 4'b0110;
        #10 buttons = 4'b0000;
        #30 buttons = 4'b0001;
        #10;
        #20 buttons = 4'b0000;
        #20;
        $display("pressed_one: %b", pressed_one);
        $finish();
    end


endmodule

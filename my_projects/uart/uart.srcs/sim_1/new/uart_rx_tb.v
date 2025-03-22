`timescale 1ns / 1ps


module uart_rx_tb();
    localparam PERIOD = 10;
    //
    localparam UART_FREQ = 2;
    localparam CLK_FREQ = 11;
    logic clk;
    logic rx_original;
    logic [7:0] result_byte;
    logic result_ready;
    //
    uart_rx_explicit_fsm #(.UART_FREQ(UART_FREQ), CLK_FREQ(CLK_FREQ)) uut_test(.*);
    //
    forever begin
        #PERIOD clk = ~clk;
    end
    rx_original = 1;
    $stop;


endmodule

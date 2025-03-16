`timescale 1ns / 1ps

`ifndef NUM_SEGMENTS
`define NUM_SEGMENTS 8
`endif

module cool_calculator_top # (parameter NUM_SEGMENTS = `NUM_SEGMENTS)
(
    input wire clk
    , input wire BTNC
    , input wire BTNU
    , input wire BTNL
    , input wire BTNR
    , input wire BTND
    , input wire CPU_RESETN
    , output logic [NUM_SEGMENTS-1:0] anode
    , output logic [7:0] cathode);
    localparam clock_period = 10; // ns
    localparam num_cycles_milisecond = 100000; // num_cycles_milisecond * clock_period == 10^6 ns
    localparam BITS = 32;

    logic BTNL_debounced = 0;
    button_debouncing #(num_cycles_milisecond) 
    debounce_BTNL(clk, CPU_RESETN, BTNL, BTNL_debounced);

    (* mark_debug = "true" *)
    logic [NUM_SEGMENTS-1:0][3:0] encoded;
    logic [NUM_SEGMENTS-1:0]      digit_point;
    logic [31:0]                  accumulator; // value to be sent to display later

    seven_segment #(.NUM_SEGMENTS (NUM_SEGMENTS), .CLK_PER(20))
    u_seven_segment(
        .clk          (clk),
        .reset        (CPU_RESETN),
        .encoded      (encoded),
        .digit_point  (digit_point),
        .anode        (anode),
        .cathode      (cathode)
        );
    
    assign accumulator = BTNL_debounced ? 12345 : 0;

    always_ff @(posedge clk) begin
        encoded     <= accumulator;
        digit_point <= '1;
    end

endmodule

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
    // localparam num_cycles_milisecond = 2;
    // localparam BITS = 32;

    logic BTNL_debounced;
    button_debouncing #(.NUMBER_OF_CYCLES (10)) 
    debounce_BTNL(clk, CPU_RESETN, BTNL, BTNL_debounced);

    (* mark_debug = "true" *)
    logic [NUM_SEGMENTS-1:0][3:0] encoded;
    logic [NUM_SEGMENTS-1:0]      digit_point;
    logic [31:0]                  accumulator; // value to be sent to display later

    seven_segment #(.NUM_SEGMENTS (NUM_SEGMENTS))
    u_seven_segment(
        .clk          (clk),
        .reset        (CPU_RESETN),
        .encoded      (encoded),
        .digit_point  (digit_point),
        .anode        (anode),
        .cathode      (cathode)
        );
    
    always_ff @(posedge clk) begin
        encoded     <= {BTNL & BTNL_debounced};
        digit_point <= '1;
    end

endmodule

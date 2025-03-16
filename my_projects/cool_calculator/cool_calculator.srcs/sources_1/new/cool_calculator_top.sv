`timescale 1ns / 1ps

`ifndef NUM_SEGMENTS
`define NUM_SEGMENTS 8
`endif

module cool_calculator_top # (parameter NUM_SEGMENTS = `NUM_SEGMENTS)
(
    input wire clk
    , input wire BTNL
    , input wire CPU_RESETN
    , output logic [NUM_SEGMENTS-1:0] anode
    , output logic [7:0] cathode);
    // localparam num_cycles_milisecond = 2;
    // localparam BITS = 32;

    (* mark_debug = "true" *) logic debounced;
    button_debouncing #(.NUMBER_OF_CYCLES (10)) 
    debounce_BTNL(
        .clk(clk),
        .rst(CPU_RESETN),
        .button(BTNL),
        .debounced(debounced)
    );

    // (* mark_debug = "true" *)
    (* mark_debug = "true" *) logic [NUM_SEGMENTS-1:0][3:0] encoded;
    logic [NUM_SEGMENTS-1:0]      digit_point = '0;
    // (* mark_debug = "true" *) logic [31:0] accumulator; // value to be sent to display later

    seven_segment #(.NUM_SEGMENTS (NUM_SEGMENTS))
    u_seven_segment(
        .clk          (clk),
        .reset        (CPU_RESETN),
        .encoded      (encoded),
        .digit_point  (digit_point),
        .anode        (anode),
        .cathode      (cathode)
        );
    
    always @(posedge clk) begin
        if (CPU_RESETN) begin
            // active lo
            encoded <= '0;
        end else begin
            if (BTNL & debounced) 
                encoded <= {NUM_SEGMENTS{4'hF}};
            else
                encoded <= '0;
        end
    end
endmodule

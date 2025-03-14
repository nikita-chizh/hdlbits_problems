`timescale 1ns / 1ps

module button_debouncing_tb();

    // Test Parameters
    parameter NUMBER_OF_CYCLES = 3;
    
    // Signals
    logic clk;
    logic rst;
    logic button;
    logic debounced;
    
    // Instantiate the Button Debouncing module
    button_debouncing #(NUMBER_OF_CYCLES) uut (
        .clk(clk),
        .rst(rst),
        .button(button),
        .debounced(debounced)
    );

    // Generate Clock (Period = 10ns -> 100MHz)
    always #5 clk = ~clk;

    // Test Procedure
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        button = 0;
        debounced = 0;
        button = 0;
        #5 button = 1;
        #20;
        #5 button = 0;
        #20;
        // Step 2: Check if debounced is 1
        if (debounced == 1) begin
            $display("TEST PASSED: debounced = 1 after 3 cycles.");
        end else begin
            $display("TEST FAILED: debounced = %d (expected 1).", debounced);
        end

        // Finish the simulation
        #10 $finish;
    end

endmodule

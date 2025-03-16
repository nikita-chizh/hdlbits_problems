`timescale 1ns / 1ps

module button_debouncing_tb();

    // Test Parameters
    parameter NUMBER_OF_CYCLES = 3;
    
    // Signals
    logic clk;
    logic rst;
    logic button;
    logic debounced;
    
    logic [7:0][3:0] encoded;

    

    // Instantiate the Button Debouncing module
    button_debouncing #(NUMBER_OF_CYCLES) uut (
        .clk(clk),
        .rst(rst),
        .button(button),
        .debounced(debounced)
    );

    // Generate Clock (Period = 10ns -> 100MHz)
    always #5 clk = ~clk;
    
    always @(posedge clk) begin
        encoded     <= {button & debounced};
        $display("button %b debounced %b", button, debounced);
        if (encoded) begin
            $display("encoded %b", encoded);
        end
    end

    // Test Procedure
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        button = 0;
        debounced = 0;
        button = 0;
        encoded = 0;
        #110;
        #5 button = 1;
        #20;
        #5 button = 0;
        #20
        #5 button = 1;
        #110;
        // Finish the simulation
        #10 $finish;
    end

endmodule

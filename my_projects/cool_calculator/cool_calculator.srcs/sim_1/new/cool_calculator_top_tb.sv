`timescale 1ns / 1ps

module cool_calculator_top_tb();
    localparam NUM_SEGMENTS = 8;
    // module
    logic clk;
    logic BTNL;
    logic CPU_RESETN;
    logic [NUM_SEGMENTS-1:0] anode;
    logic [7:0] cathode;
    
    cool_calculator_top uut(.*);
    
    // 
    always #5 clk = ~clk;
    initial begin
        // Initialize signals
        clk = 0;
        BTNL = 0;
        CPU_RESETN = 0;
        anode = '0;
        cathode = '0;
        #10;
        #5 BTNL = 1;
        #200;
        #5 CPU_RESETN = 1;
        #200;
        #10 $finish;
    end

    
endmodule

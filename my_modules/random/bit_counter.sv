`timescale 1ns / 1ps


module bit_counter(input clk, input [7:0] incoming_byte, output [4:0] ones_num);
    logic [4:0] res;
    always_ff @( posedge clk)
        res <= $countones(incoming_byte);
    assign ones_num = res;    
endmodule

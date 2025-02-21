`timescale 1ns / 1ps
`define H 4

module add_sub_tb();
    parameter  SELECTOR_ADD = "ADD";
    parameter BITS_NUM = `H * 2;
    parameter HALF_BITS = `H;
    logic [BITS_NUM-1: 0] input_sw = 0;
    logic signed [BITS_NUM-1: 0] add_result = 0;
    //
    add_sub #(.SELECTOR(SELECTOR_ADD), .BITS(BITS_NUM)) adder (.SW(input_sw), .LED(add_result));
    logic [BITS_NUM-1:0] testcases[0:4] = {
        {`H'd1,  `H'd2},     // generic
        {-`H'd4, `H'd7},   // check first negative
        {`H'd7,  -`H'd1},   // check second negative  
        {-`H'd1, -`H'd2},   // check both negative
        {`H'd15,  `H'd15}      // check overflow
    };
    logic signed [`H-1:0]       a_in;
    logic signed [`H-1:0]       b_in;
    integer testcase = 0;
    initial begin
    for (testcase = 0; testcase < $size(testcases); ++testcase)
        begin
            input_sw = testcases[testcase];
            {a_in, b_in} = input_sw;
            $display("testcase = %d  input_sw_high == %b input_sw_low == %b", testcase, a_in, b_in);
            #10;
            $display("add_result == %b add_result_d == %d", add_result, add_result);
        end
    end
endmodule

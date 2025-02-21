`timescale 1ns / 1ps

module add_sub_tb();
    parameter  SELECTOR_ADD = "ADD";
    parameter BITS_NUM = 8;
    logic [BITS_NUM-1: 0] input_sw = 0;
    logic signed [BITS_NUM-1: 0] add_result = 0;
    //
    add_sub #(.SELECTOR(SELECTOR_ADD), .BITS(BITS_NUM)) adder (.SW(input_sw), .LED(add_result));
    logic [BITS_NUM-1:0] testcases[4:0] = {
        {{BITS_NUM{1} }, {BITS_NUM{2} } },     // generic
        {{BITS_NUM{-1}}, {BITS_NUM{15}} },   // check first negative
        {{BITS_NUM{15}}, {BITS_NUM{-1}} },   // check second negative  
        {{BITS_NUM{-1}}, {BITS_NUM{-2}} },   // check both negative
        {{BITS_NUM{15}}, {BITS_NUM{1} } }      // check overflow
    };
    integer testcase = 0;
    initial begin
    for (testcase = 0; testcase < $size(testcases); ++testcase)
        begin
            input_sw = testcases[testcase];
            #1;
        end
    end

    always @(add_result) begin
        $display("testcase = %d add_result == %b add_result_d == %d", testcase, add_result, add_result);
    end
endmodule

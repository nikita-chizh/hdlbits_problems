`timescale 1ns/10ps


module moore_calc_tb();
import calculator_pkg::*;

localparam BITS = 16;
localparam PERIOD = 10;
typedef enum bit [4:0]  {
    MULT =  5'b00001
    , DIV = 5'b00010
    , ADD = 5'b00100
    , SUB = 5'b01000
    } buttons_encoded;

logic clk;
logic reset;
logic start;
logic [4:0] operation;
logic signed [15:0] operand;
logic [BITS-1:0]  accum;
integer counter;


typedef struct {
    logic [4:0] operation;
    logic signed [BITS-1:0] op1;
    logic signed [BITS-1:0] op2;
} testcase_t;

testcase_t testcases [3:0];



calculator_moore #(.BITS (BITS)) calculator_moore_test(.*);


initial begin
    counter = 0;
    // module vars
    clk = 0;
    reset = 0;
    start = 0;
    operation = '0;
    operand = '0;
    accum = '0;
    // testcases
    testcases[0] = '{operation: MULT, op1: 11,  op2: 2};
    // testcases[1] = '{operation: DIV,  op1: 5,   op2: 2};
    // testcases[2] = '{operation: ADD,  op1: 226, op2: 2};
    // testcases[3] = '{operation: SUB,  op1: 123, op2: 123};
    forever begin
        #PERIOD clk = ~clk;
    end
end

always @(posedge clk) begin
    counter <= counter + 1;
    case (counter)
        0: begin
            // setttig up testcase
            operation <= testcases[0].operation;
            operand <= testcases[0].op1;
            start <= 1;
        end
        1: begin
            operand <= testcases[0].op2;
        end 
        2: begin
            start <= 0;
        end 
    endcase
    $display("accum %d counter %d", accum, counter);
    if (counter == 8)
        $stop;
end


endmodule

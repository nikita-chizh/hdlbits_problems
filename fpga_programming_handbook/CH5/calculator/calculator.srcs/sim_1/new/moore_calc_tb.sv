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
logic [4:0] buttons;
logic signed [15:0] operand;
logic [BITS-1:0]  accum;
integer counter;


typedef struct {
    logic [4:0] buttons;
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
    buttons = '0;
    operand = '0;
    accum = '0;
    // testcases
    testcases[0] = '{buttons: MULT, op1: 11,  op2: 2};
    // testcases[1] = '{buttons: DIV,  op1: 5,   op2: 2};
    // testcases[2] = '{buttons: ADD,  op1: 226, op2: 2};
    // testcases[3] = '{buttons: SUB,  op1: 123, op2: 123};
    forever begin
        #PERIOD clk = ~clk;
    end
end

always @(posedge clk) begin
    counter <= counter + 1;
    case (counter)
        1: begin
            // setttig up testcase
            buttons <= testcases[0].buttons;
            operand <= testcases[0].op1;
            start <= 1;
        end
        2: operand <= testcases[0].op2;
        5: begin
            start <= 0;
            reset <= 1;
        end 
    endcase
    $display("accum %d counter %d", accum, counter);
    if (counter == 8)
        $stop;
end


endmodule

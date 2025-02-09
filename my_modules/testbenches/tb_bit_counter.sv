`timescale 1ns / 1ps

module tb_bit_counter();
localparam PERIOD = 10;
localparam TESTCASES = 10;
logic clk_;
logic [7:0] incoming_byte_;
logic [7:0] prev_incoming_byte_;

logic [4:0] ones_num_;
integer testcase;
bit_counter bitCounter(clk_, incoming_byte_, ones_num_);

initial begin
    clk_ = 0;
    prev_incoming_byte_ = 0;
    incoming_byte_ = 0;
    ones_num_ = 0;
    testcase = 0;
    forever begin
        #PERIOD clk_ = ~clk_;
    end
end

always @(posedge clk_) begin
    prev_incoming_byte_ <= incoming_byte_;
    incoming_byte_ <= incoming_byte_ + 1;
end

always @(posedge clk_) begin
    testcase += 1;
    if (testcase == TESTCASES)
        $stop;
    $display("running incoming_byte_: %b  prev_incoming_byte_: %b ones_num_: %b"
            , incoming_byte_, prev_incoming_byte_, ones_num_);
    assert (ones_num_ == $countones(prev_incoming_byte_)) 
    else   $error("ones_num_ != countones(prev_incoming_byte_) %b, %b", ones_num_, prev_incoming_byte_);
end

endmodule

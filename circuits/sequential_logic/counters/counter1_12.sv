module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //

    always_ff @(posedge clk)


    count4 the_counter (clk, c_enable, c_load, c_d);
    assign Q = c_d;
    

endmodule

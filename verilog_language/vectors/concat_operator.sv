// sign-extends an 8-bit number to 32 bits
module top_module (
    input [7:0] in,
    output [31:0] out );//

    assign out[31:0] = { {24{in[7]}} , in[7:0] }; // outer {} is a must!

endmodule

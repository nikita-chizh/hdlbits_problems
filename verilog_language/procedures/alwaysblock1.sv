// synthesis verilog_input_version verilog_2001
module top_module(
    input a, 
    input b,
    output wire out_assign,
    output reg out_alwaysblock
);

    assign out_assign = a & b;
    always @ (*) begin // (a or b)
		out_alwaysblock = a & b;
	end
endmodule

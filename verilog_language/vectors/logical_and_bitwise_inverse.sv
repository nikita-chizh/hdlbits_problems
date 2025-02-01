module KEK_NET ( 
    input wire [2:0] a,
    output wire [2:0] b,
    output wire [2:0] c);
	assign b = ~a;
	assign c = !a;
endmodule
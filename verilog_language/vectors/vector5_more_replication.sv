module top_module (
    input a, b, c, d, e,
    output [24:0] out );

    // The output is XNOR of two vectors created by 
    // concatenating and replicating the five inputs.
    /*
    assign out = {
          {5{~a}} ^ { a, b, c, d, e }
        , {5{~b}} ^ { a, b, c, d, e }
        , {5{~c}} ^ { a, b, c, d, e }
        , {5{~d}} ^ { a, b, c, d, e }
        , {5{~e}} ^ { a, b, c, d, e }
    };
    */
    /*
	wire [24:0] top, bottom;
	assign top    = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
	assign bottom = {5{a,b,c,d,e}};
	assign out = ~top ^ bottom;	// Bitwise XNOR
    */

    /*
    // {~5{a}} did not work {5~{a}} did not compile
    assign out = {
          ~{5{a}} ^ { a, b, c, d, e }
        , ~{5{b}} ^ { a, b, c, d, e }
        , ~{5{c}} ^ { a, b, c, d, e }
        , ~{5{d}} ^ { a, b, c, d, e }
        , ~{5{e}} ^ { a, b, c, d, e }
    };
    */
endmodule

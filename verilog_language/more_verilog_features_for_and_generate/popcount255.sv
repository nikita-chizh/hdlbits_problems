module top_module( 
    input [254:0] in,
    output reg [7:0] out );

    always @ (*)
    begin
        out = 0; //
        for (integer i = 0; i < 255; i += 1)
        begin
            out = out + in[i];
        end
    end
endmodule


// also would work
module top_module( 
    input [2:0] in,
    output [1:0] out );

    always_comb begin
        out = 0; //
        for (integer i = 0; i < 3; i += 1)
        begin
            out = out + in[i];
        end
    end
endmodule

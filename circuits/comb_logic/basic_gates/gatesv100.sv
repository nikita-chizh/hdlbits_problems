module top_module( 
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different );

    always_comb begin solve_both:
        for (integer i = 98; i >= 0; i -= 1)
        begin
           out_both[i] = in[i+1] & in[i];
        end
    end
    
    always_comb begin solve_any:
        for (integer i = 99; i >= 1; i -= 1)
        begin
           out_any[i] = in[i] | in[i-1];
        end
    end

    always_comb begin solve_different:
        out_different[99] = in[99] != in[0];
        for (integer i = 98; i >= 1; i -= 1)
        begin
           out_different[i] = in[i+1] != in[i];
        end

        out_different[0] = in[1] != in[0];
    end


endmodule

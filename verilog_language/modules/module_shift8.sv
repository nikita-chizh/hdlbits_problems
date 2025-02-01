module top_module (input clk, input [7:0] d, input [1:0] sel, output [7:0] q);
    wire[7:0] q0, q1, q2, res;
    my_dff8  r0(clk, d, q0);
    my_dff8  r1(clk, q0, q1);
    my_dff8  r2(clk, q1, q2);
    // multiplexor here
    always @*
    begin
        if (sel == 2'd0)
        begin
            res <= d;
        end
        else if (sel == 2'd1)
        begin
            res <= q0;
        end 

        else if (sel == 2'd2)
        begin
            res <= q1;
        end

        else
        begin
            res <= q2;
        end
    end
    assign q = res;
endmodule

// why it did not work with always @(posedge clk) ?
// was shifted left on 1 cycle?
// because <= makes assignment when clk changed, but others have not propagated yet!!!

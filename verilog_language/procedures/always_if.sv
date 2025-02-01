// synthesis verilog_input_version verilog_2001
module top_module(
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output wire out_assign,
    output reg out_always   ); 
    wire choose_b = sel_b1 & sel_b2;
    assign out_assign = (choose_b) ? b : a;
    always @ (*) begin
        if (choose_b)
        begin
            out_always = b; // NO "assign" STATEMENT!!!
        end
        else
        begin
            out_always = a;
        end
	end
endmodule

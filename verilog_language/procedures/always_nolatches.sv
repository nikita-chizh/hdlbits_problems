// synthesis verilog_input_version verilog_2001
module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up  );

    always @ (*)
    begin
    case (scancode)
        16'he06b:
        begin
            left = 1;
            {down, right, up} = 3'b000;
        end
        16'he072:
        begin
            down = 1;
            {left, right, up} = 3'b000;
        end
        16'he074:
        begin
            right = 1;
            {left, down, up} = 3'b000;
        end
        16'he075:
        begin
            up = 1;
            {left, down, right} = 3'b000;
        end
        default:
            {left, down, right, up} = 4'b0000;
    endcase
	end
endmodule

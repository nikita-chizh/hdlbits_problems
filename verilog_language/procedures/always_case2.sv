module top_module (
    input [3:0] in,
    output reg [1:0] pos  );

    always@(*) begin  // This is a combinational circuit
        if (in & 4'b0001)
            pos = 0;
        else if (in & 4'b0010)
            pos = 1;
        else if (in & 4'b0100)
            pos = 2;
        else if (in & 4'b1000)
            pos = 3;
        else
            pos = 0;
    end

endmodule



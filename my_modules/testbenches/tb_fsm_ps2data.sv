`timescale 1ns / 1ps

module tb_fsm_ps2data();

localparam PERIOD = 10;
localparam N = 12;
logic clk;
logic [7:0] in;
integer counter;
logic reset;
logic [23:0] out_bytes;
logic done;
logic [7:0] incoming_bytes [N:0];

fsm_ps2data fsm_ps2data_tesable(clk, in, reset, out_bytes, done);

initial begin
    clk = 0;
    in = 0;
    counter = 0;
    reset = 0;
    out_bytes = 0;
    done = 0;
    incoming_bytes[0] = 8; // start
    incoming_bytes[1] = 1;
    incoming_bytes[2] = 1; // should be done
    incoming_bytes[3] = 1; // should be wait
    incoming_bytes[4] = 8; // new packet
    incoming_bytes[5] = 1;
    incoming_bytes[6] = 1;
    incoming_bytes[7] = 8; // done and new
    incoming_bytes[8] = 1;
    incoming_bytes[9] = 1;
    incoming_bytes[10] = 1;
    incoming_bytes[11] = 1;
    incoming_bytes[12] = 1;
    //
    forever begin
        #PERIOD clk = ~clk;
    end
end

always @(posedge clk) begin
    counter <= counter + 1;
    in <= incoming_bytes[counter];
end

always @(posedge clk) begin
    if (counter == N)
        $stop;
    $display("running counter: %b  out_bytes: %b", counter, out_bytes);
end

endmodule

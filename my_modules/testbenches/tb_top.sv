`timescale 1ns / 1ps

module tb_top();

logic x_byte = 4'bxxx1;
logic z_byte = 4'bzzz1;
logic q_byte = 4'b???1;
logic real_byte = 4'b1111;

top tested_module(a, b, kek);
initial begin
    // logic same_real_byte = 8'b11111111;
//    $display("x_byte == %d",  x_byte==real_byte);
//    $display("x_byte === %d", x_byte===real_byte);
//    $display("z_byte == %d",  z_byte==real_byte);
//    $display("z_byte === %d", z_byte===real_byte);
//    $display("q_byte == %d",  q_byte==real_byte);
//    $display("q_byte === %d", q_byte===real_byte);
    //
    $display("x_byte =?= %d", x_byte=?=real_byte);
    $display("z_byte =?= %d", z_byte=?=real_byte);
    $display("q_byte =?= %d", q_byte=?=real_byte);
    //
//     $display("same_real_byte == %d", same_real_byte==real_byte);
//     $display("same_real_byte === %d", same_real_byte===real_byte);

    
end
assign a = z_byte=?=real_byte;
logic [3:0] address = 4'b0011;
logic slot;

always_comb begin
    if (address[3:0] =?= 4'b00zz)
        slot = 0;
    else if (address[3:0] =?= 4'b01zz)
        slot = 1;
    $display("a: %d, slot: %d", a, slot);
end


endmodule

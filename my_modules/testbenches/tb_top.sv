`timescale 1ns / 1ps

module tb_top();

logic a, b, kek;

top tested_module(a, b, kek);
initial begin
    logic x_byte = 8'bxxxx1xxx;
    logic z_byte = 8'bzzzz1zzz;
    logic q_byte = 8'b????1???;
    logic real_byte = 8'b11111111;
    logic same_real_byte = 8'b11111111;
    $display("x_byte == %d",  x_byte==real_byte);
    $display("x_byte === %d", x_byte===real_byte);
    $display("z_byte == %d",  z_byte==real_byte);
    $display("z_byte === %d", z_byte===real_byte);
    $display("q_byte == %d",  q_byte==real_byte);
    $display("q_byte === %d", q_byte===real_byte);
    $display("same_real_byte == %d", same_real_byte==real_byte);
    $display("same_real_byte === %d", same_real_byte===real_byte);

end


endmodule

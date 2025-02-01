module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    wire and1;
    wire and2;
    assign and1 = a & b;
    assign and2 = c & d;
    //
    wire intermidiate_res;
    assign intermidiate_res = and1 | and2;
    assign out = intermidiate_res;
    assign out_n = !intermidiate_res;
endmodule

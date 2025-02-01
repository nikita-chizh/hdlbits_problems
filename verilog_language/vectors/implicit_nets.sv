module KEK_NET ( 
    input wire [2:0] a,
    output wire [2:0] b); // Module body starts after module declaration
	assign c = !a;  // c is implicitly defined 1 bit 
	assign b = c;
endmodule

// testbench
module And_Gate_TB(); // 1
  
  reg  [2:0] r_a;
  wire [2:0] b_out;
  KEK_NET UUT(r_a, b_out);
  initial
    begin
      $dumpfile("dump.vcd"); $dumpvars;
      r_a <= 3'b000;
      #10;
      assert (b_out == 3'b111); // b was 001 !!! 
      $finish();
    end
endmodule
module KEK ( 
    input wire a,
    output wire b); // Module body starts after module declaration
	assign c = !a;  // c is implicitly defined 1 bit 
	assign b = c;
endmodule


// testbench
module And_Gate_TB();
  reg r_a;
  wire b_out;
  KEK UUT(r_a, b_out);
  initial
    begin
      $dumpfile("dump.vcd"); $dumpvars;
      r_a <= 1'b0;
      #10;
      assert (b_out == 1'b1);
      $finish();
    end
endmodule
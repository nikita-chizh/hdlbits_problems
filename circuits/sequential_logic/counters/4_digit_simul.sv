module Debounce_Filter_TB ();
 
    reg _clk = 0;
    reg _reset = 0;
    reg [3:1] _ena;
    reg [15:0] _q;
    always #2 _clk <= !_clk; /*1*/
 	top_module tested(_clk, _reset, _ena, _q);
    
    initial begin /*3*/
        // Required for EDA Playground
        $dumpfile("dump.vcd"); 
        $dumpvars;
        
        repeat(8) @(posedge _clk);
        assert (_q[3:0] == 8);


        $display("Test Complete");
        $finish();
    end
   
endmodule
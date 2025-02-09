// ####################################### ASSIGNMENTS #######################################

// ############# Assign operator. #############
// Basically the lowest level connection with wires. can end up in the simpliest hardware possible.
assign a = b;
assign a = 1'b1;

// ############# Blocking assignment. #############
// in fact we only need it to use if/else, case etc.
// generally ends up with combinational logic + edi can throw warning/error if you ended up with a latch
always_comb begin : kek
    if (b == 10)
        a = b;
    else
        a = c;
end

// ############# Non-Blocking assignment. #############
// generate flip-flops / registers and move data from one state to another
// flip-flop just like in electronics books (logically)
logic s_reg[3:0];
always_ff @( posedge clk) begin : shift_reg
    s_reg[0] <= s_reg[1];
    s_reg[1] <= s_reg[2];
    s_reg[2] <= s_reg[3];
    s_reg[3] <= s_reg[0];
end

// ############# BITS WIDTH assignment. #############

logic [31: 0] a_vect;
logic [0 :31] b_vect;
logic [63: 0] dword;
integer sel;
a_vect[ 0 +: 8] // == a_vect[ 7 : 0]
a_vect[15 -: 8] // == a_vect[15 : 8]
b_vect[ 0 +: 8] // == b_vect[0 : 7]
b_vect[15 -: 8] // == b_vect[8 :15]
dword[8*sel +: 8] // variable part-select with fixed width


// ####################################### DATA TYPES #######################################


// ####################################### ARRAYS #######################################
logic [7:0] incoming_bytes [12:0]; // 2d array 12 elements each [7:0]

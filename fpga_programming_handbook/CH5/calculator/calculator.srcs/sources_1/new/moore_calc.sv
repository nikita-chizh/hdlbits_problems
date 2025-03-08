`timescale 1ns/10ps
module calculator_moore #(parameter BITS = 32)
  (
    input wire               clk,
    input wire               reset,
    input wire               start,
    input wire [4:0]         buttons,
    input wire signed [BITS-1:0] operand,

    output logic [BITS-1:0]  accum
   );
  import calculator_pkg::*;

  localparam BC     = $clog2(BITS);

  (* mark_debug = "true" *) logic [4:0]       op_store;
  (* mark_debug = "true" *) logic [4:0]       op_todo;
  (* mark_debug = "true" *) logic [BITS-1:0]  accumulator;

  typedef enum bit [2:0] {IDLE, WAIT4BUTTON, ADD, SUB, MULT, DIV, RESET} state_t;

  (* mark_debug = "true" *) state_t state;
  initial begin
    accumulator = '0;
    state = IDLE;
  end

  always @(posedge clk) begin
    case (state)
      IDLE: begin
        op_todo     <= buttons; // operation to perform
        accumulator <= operand;
        if (start) // 
            state <= WAIT4BUTTON;
      end
      WAIT4BUTTON: begin
        // istantly transfers us to actuall op_todo execution logic
        case (1'b1) // one-hot encoding
          op_todo[UP]:     state <= MULT;
          op_todo[DOWN]:   state <= DIV;
          op_todo[LEFT]:   state <= ADD;
          op_todo[RIGHT]:  state <= SUB;
          default:         state <= IDLE; // center drops op
        endcase // case (1'b1)
      end
      // op_todo execution logic
      MULT: begin
        accumulator <= accumulator * operand;
        state       <= IDLE;
      end
      ADD: begin
        accumulator <= accumulator + operand;
        state       <= IDLE;
      end
      SUB: begin
        accumulator <= accumulator - operand;
        state       <= IDLE;
      end
      DIV: begin
        if (operand != 0)
          accumulator <= accumulator / operand;
        else
          accumulator <= 0;
        state       <= IDLE;
      end
      RESET: begin
        accumulator <= '0;
        state       <= IDLE;
        op_todo     <= '0;
      end
    endcase // case (state)
    if (reset)
        state <= RESET;
  end

  assign accum = accumulator;

endmodule


`timescale 1ns / 1ps

module uart_rx_explicit_fsm #(parameter UART_FREQ, parameter CLK_FREQ, parameter PARITY_BIT_SUPPORT = 0)
(input clk, input rx_original, output logic [7:0] result_byte, output logic result_ready);
    
    typedef enum {WAIT, DATA_ACP, DONE} RX_STATE;
    RX_STATE STATE;

    localparam ONE_BIT_CLKN = CLK_FREQ / UART_FREQ;
    logic [$clog2(ONE_BIT_CLKN)-1:0] one_bit_counter;
    logic [7:0] result;
    logic [3:0] result_idx;
    logic is_result_ready;
    logic clk_br;

    always_ff @(posedge clk) begin
		if (one_bit_counter != ONE_BIT_CLKN) begin
			one_bit_counter <= one_bit_counter + 1;
			clk_br <= 0;
		end else begin
			one_bit_counter <= '0;
			clk_br <= 1;
		end
	end
	
    always @(posedge clk_br) begin
        case (STATE)
            WAIT: begin
                result <= '0;
                result_idx <= '0;
                is_result_ready <= 0;
                STATE <= (~rx_original ? DATA_ACP : WAIT);
            end
            DATA_ACP: begin
                if (result_idx[3]) begin
                    STATE <= DONE;
                end else begin
                    result[result_idx] <= rx_original;
                    result_idx <= result_idx + 1;
                    STATE <= DATA_ACP;
                end
            end
            DONE: begin
                is_result_ready <= rx_original; // stop bit, if not 1 packet is missed
                STATE <= WAIT;
            end
            default :
                STATE <= WAIT;
      endcase
    end
    
    assign result_byte = result;
    assign result_ready = is_result_ready;
endmodule

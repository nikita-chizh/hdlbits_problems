module UART_VERILOG 
#(
	parameter on_count_rate = 21,
)
(
	input wire clk, // тактовый сигнал
	input wire rx_serial, // rx линия
	output wire [7:0] rx_data, // принятые данные
	output wire rx_vd, // Валидация данных
	output wire ready_tx // готовность контроллера
);
	// Счетчик подсчета тактового сигнала
	reg [7:0] counter_rate = 0;
	// Счетчик подсчета принятых битов
	reg [3:0] counter_bits_rx = 0;
	// Счетчик подсчета посланных битов
	reg [3:0] counter_bits_tx = 0;
	
	// тактовый сигнал UART
	reg clk_br = 0;
	// регистр первого принятого бита
	reg _first_bit_rx = 0;
	// регистр принимающий через clk_br
	reg [11:0] tx_data_reg = 0;
	// регистр принимающий через clk
	reg [7:0] tx_termclk = 0;
	// регистр готовности контроллера
	reg ready_trns = 1;
	// [7:0] - без бита четности. [8:0] - с битом четности
	reg [8:0] rx_data_reg;
	// регистр бита четности при передачи
	reg parity = 0;
	// флаг полученных данных через clk
	reg flag_start_tx = 0;
	// флаг получение инф о лог. 1 на валидации
	reg	first_clk_vd = 0;
	// ограничитель сигнала валидации в один такт
	reg	limit_vd = 0;
	// флаг контроля лог. уровня сигнала clk_br
	reg	edge_clk_br = 0;
	
	wire			wire_vd_rx;
	
	assign	rx_data = rx_data_reg[7:0],
			rx_vd = limit_vd;
	
	assign wire_vd_rx = counter_bits_rx[3] & rx_serial;

	always @(posedge clk) begin
		if ((on_count_rate - 1) != counter_rate) begin
			counter_rate <= counter_rate + 1;
			clk_br <= 0;
		end else begin
			counter_rate <= 0;
			clk_br <= 1;
		end
		
		if (wire_vd_rx) begin
			if (~first_clk_vd) begin
				first_clk_vd <= 1;
				limit_vd <= 1;
			end else begin
				limit_vd <= 0;
			end
		end else begin
			first_clk_vd <= 0;
		end
	end
	
	integer i;
	generate
		always @(posedge clk_br) begin
			// последовательно-параллельный регистр
			rx_data_reg[7] <= rx_serial;
			for (i = 1; i < 8; i = i + 1) begin
				rx_data_reg[i - 1] <= rx_data_reg[i];
			end
			
			// первый бит передачи
			if (~rx_serial & ~_first_bit_rx) begin
				_first_bit_rx <= 1;
			end else if (_first_bit_rx) begin
				if (counter_bits_rx < 10) begin // 10 ??? 
					counter_bits_rx <= counter_bits_rx + 1;
					parity <= parity ^ rx_serial;
				end else begin
					counter_bits_rx <= 0;
					parity <= 0;
					_first_bit_rx <= 0;
				end
			end
		end
	endgenerate
	
endmodule

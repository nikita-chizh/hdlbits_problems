module UART_VERILOG 
#(
	parameter TX_ENABLE = 1, // контроллер может отправлять данные
	parameter RX_ENABLE = 1, // контроллер может принимать данные
	// on_count_rate = (CLK_FREQ/BAUDRATE)
	// CLK_FREQ - Это частота clk
	// BAUDRATE - бит/сек
	// Моя частота 200_000kHz и 9600 бит/сек (12000 бод)
	// on_count_rate = 200_000 / 9600 = 20,83333. Округляем до 21
	parameter on_count_rate = 21,
	parameter PARITY_ENABLE = 1 // учитывать 8 битом бит четности
)
(
	input wire clk, // тактовый сигнал
	input wire rx_serial, // rx линия
	output wire [7:0] rx_data, // принятые данные
	output wire rx_vd, // Валидация данных
	output wire tx_serial, // tx линия
	input wire [7:0] tx_data, // посылаемые данные
	input wire tx_vd, // Валидация данных
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
	
	generate
		if (PARITY_ENABLE == 1) begin
			assign wire_vd_rx = ~parity & (counter_bits_rx == 9)
							& rx_serial & ~clk_br;
		end else begin
			assign wire_vd_rx = counter_bits_rx[3] & rx_serial;
		end
	endgenerate
	
	assign	ready_tx = ready_trns,
			tx_serial = tx_data_reg[0] | ready_trns;

	always @(posedge clk) begin
		if ((on_count_rate - 1) != counter_rate) begin
			counter_rate <= counter_rate + 1;
			clk_br <= 0;
		end else begin
			counter_rate <= 0;
			clk_br <= 1;
		end
		
		if (tx_vd & ready_trns) begin
			tx_termclk <= tx_data;
			flag_start_tx <= 1;
			if (clk_br)
				edge_clk_br <= 1;
			else
				edge_clk_br <= 0;
		end else begin
			if (clk_br & ~edge_clk_br) begin
				flag_start_tx <= 0;
			end
			if (~clk_br & edge_clk_br) begin
				edge_clk_br <= 0;
			end
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
		if (RX_ENABLE) begin
			always @(posedge clk_br) begin
				// последовательно-параллельный регистр
				if (PARITY_ENABLE == 1) begin
					rx_data_reg[8] <= rx_serial;
					for (i = 1; i < 9; i = i + 1) begin
						rx_data_reg[i - 1] <= rx_data_reg[i];
					end
				end else begin
					rx_data_reg[7] <= rx_serial;
					for (i = 1; i < 8; i = i + 1) begin
						rx_data_reg[i - 1] <= rx_data_reg[i];
					end
				end
				
				// первый бит передачи
				if (~rx_serial & ~_first_bit_rx) begin
					_first_bit_rx <= 1;
				end else if (_first_bit_rx) begin
					if (PARITY_ENABLE == 0) begin
						if (~counter_bits_rx[3]) begin
							counter_bits_rx <= counter_bits_rx + 1;
						end else begin
							counter_bits_rx <= 0;
							_first_bit_rx <= 0;
						end
					end else begin
						if (counter_bits_rx < 10) begin
							counter_bits_rx <= counter_bits_rx + 1;
							parity <= parity ^ rx_serial;
						end else begin
							counter_bits_rx <= 0;
							parity <= 0;
							_first_bit_rx <= 0;
						end
					end
				end
			end
		end
	endgenerate
	
	integer j;
	generate
		if (TX_ENABLE) begin
			always @(posedge clk_br) begin
				if (flag_start_tx) begin
					if (PARITY_ENABLE == 1) begin
						tx_data_reg[0] <= 0;
						tx_data_reg[8:1] <= tx_termclk;
						tx_data_reg[9] <= ^ tx_termclk;
						tx_data_reg[10] <= 1;
						tx_data_reg[11] <= 1;
					end else begin
						tx_data_reg[0] <= 0;
						tx_data_reg[8:1] <= tx_termclk;
						tx_data_reg[9] <= 1;
						tx_data_reg[10] <= 1;
					end
					ready_trns <= 0;
				end
				if (~ready_trns & ~tx_vd) begin
					
					if (PARITY_ENABLE == 0) begin
						for (j = 0; j < 10; j = j + 1) begin
							tx_data_reg[j] <= tx_data_reg[j + 1];
						end
						if (counter_bits_tx == 9) begin
							ready_trns <= 1;
						end
					end else begin
						for (j = 0; j < 11; j = j + 1) begin
							tx_data_reg[j] <= tx_data_reg[j + 1];
						end
						if (counter_bits_tx == 10) begin
							ready_trns <= 1;
						end
					end
					counter_bits_tx = counter_bits_tx + 1;
				end else begin
					counter_bits_tx = 0;
				end
			end
		end
	endgenerate
	
endmodule

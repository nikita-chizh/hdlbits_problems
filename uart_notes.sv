// validation in ru:
// Счетчик подсчета принятых битов
reg [3:0] counter_bits_rx = 0; //4 bits so up to 15
assign wire_vd_rx = counter_bits_rx[3] & rx_serial; // means that byte is gathered

// 
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

// posedge clk 
// one cycle 
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

// same for nandland
s_CLEANUP :
    begin
    r_SM_Main <= s_IDLE;
    r_Rx_DV   <= 1'b0;
    end

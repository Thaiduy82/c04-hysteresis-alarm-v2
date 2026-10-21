module threshold_alarm_hysteresis (
    input  wire       clk,          // Xung nhịp hệ thống
    input  wire       rst_n,        // Reset (tích cực mức 0)
    input  wire [7:0] ui_in,        // Mẫu dữ liệu đầu vào (Sample)[cite: 1, 2]
    input  wire [7:0] uio_in,       // Dữ liệu cài đặt ngưỡng[cite: 1, 2]
    input  wire       thresh_sel,   // 0: nạp Ngưỡng dưới, 1: nạp Ngưỡng trên
    output reg        alarm_out,    // uo_out[0]: Cảnh báo[cite: 1, 2]
    output reg        in_hyst       // uo_out[1]: Đang ở vùng trễ[cite: 1, 2]
);

    // Thanh ghi lưu giữ 2 ngưỡng
    reg [7:0] th_low;
    reg [7:0] th_high;

    // Logic nạp ngưỡng
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            th_low  <= 8'd50;   // Ngưỡng dưới mặc định = 50
            th_high <= 8'd150;  // Ngưỡng trên mặc định = 150
        end else begin
            if (thresh_sel == 1'b0)
                th_low <= uio_in;
            else
                th_high <= uio_in;
        end
    end

    // Logic vùng trễ (Hysteresis)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            alarm_out <= 1'b0;
            in_hyst   <= 1'b0;
        end else begin
            if (ui_in > th_high) begin
                alarm_out <= 1'b1;  // Vượt ngưỡng trên -> Bật cảnh báo[cite: 1]
                in_hyst   <= 1'b0;
            end else if (ui_in < th_low) begin
                alarm_out <= 1'b0;  // Giảm dưới ngưỡng dưới -> Tắt cảnh báo[cite: 1]
                in_hyst   <= 1'b0;
            end else begin
                // Trong vùng giữa 2 ngưỡng -> Giữ nguyên trạng thái cũ[cite: 1]
                alarm_out <= alarm_out;
                in_hyst   <= 1'b1;
            end
        end
    end

endmodule
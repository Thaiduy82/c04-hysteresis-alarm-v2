module threshold_alarm_hysteresis (
    input  wire        clk,         // Xung nhịp hệ thống
    input  wire        rst_n,       // Reset (tích cực mức 0)
    input  wire [7:0]  ui_in,       // Mẫu dữ liệu đầu vào (Sample)
    input  wire [7:0]  uio_in,      // Dữ liệu cài đặt ngưỡng
    input  wire        thresh_sel,  // 0: nạp Ngưỡng dưới, 1: nạp Ngưỡng trên
    output reg         alarm_out,   // uo_out[0]: Cảnh báo
    output reg         in_hyst      // uo_out[1]: Đang ở vùng trễ
);

    // Thanh ghi lưu giữ 2 ngưỡng
    reg [7:0] th_low;
    reg [7:0] th_high;

    // Logic nạp ngưỡng có điều kiện qua tín hiệu chọn thresh_sel
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

    // Logic xử lý cảnh báo kết hợp vùng trễ (Hysteresis)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            alarm_out <= 1'b0;
            in_hyst   <= 1'b1;
        end else begin
            if (ui_in > th_high) begin
                alarm_out <= 1'b1;  // Vượt ngưỡng trên -> Bật cảnh báo
                in_hyst   <= 1'b0;  // Thoát khỏi vùng trễ
            end else if (ui_in < th_low) begin
                alarm_out <= 1'b0;  // Giảm dưới ngưỡng dưới -> Tắt cảnh báo
                in_hyst   <= 1'b0;  // Thoát khỏi vùng trễ
            end else begin
                // Nằm trong vùng trễ giữa th_low và th_high -> Giữ nguyên trạng thái cảnh báo cũ
                alarm_out <= alarm_out;
                in_hyst   <= 1'b1;  // Đang nằm trong vùng trễ
            end
        end
    end

endmodule
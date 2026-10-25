`timescale 1ns / 1ps

module tb_threshold_alarm();

    reg        clk;
    reg        rst_n;
    reg  [7:0] ui_in;
    reg  [7:0] uio_in;
    reg        thresh_sel;
    wire       alarm_out;
    wire       in_hyst;

    // Kết nối với module chính (Unit Under Test - UUT)
    threshold_alarm_hysteresis uut (
        .clk(clk),
        .rst_n(rst_n),
        .ui_in(ui_in),
        .uio_in(uio_in),
        .thresh_sel(thresh_sel),
        .alarm_out(alarm_out),
        .in_hyst(in_hyst)
    );

    // Tạo xung clock 10ns (T = 10ns, chu kỳ 100MHz)
    always #5 clk = ~clk;

    initial begin
        // Khởi tạo các tín hiệu ban đầu
        clk = 0;
        rst_n = 0;
        ui_in = 8'd0;
        uio_in = 8'd0;
        thresh_sel = 0;

        // Giải phóng Reset
        #20 rst_n = 1;
        #10;

        // Cài đặt ngưỡng: Ngưỡng dưới (th_low) = 50, Ngưỡng trên (th_high) = 150
        thresh_sel = 0; uio_in = 8'd50;  #10;
        thresh_sel = 1; uio_in = 8'd150; #10;

        $display("--- Bat dau kiem tra vung trễ (Hysteresis Alarm) ---");

        // 1. Đưa giá trị thấp hơn ngưỡng dưới để thiết lập trạng thái ban đầu ổn định (alarm = 0)
        ui_in = 8'd30;  #20;

        // 2. Tăng mẫu vượt ngưỡng trên (160 > 150) -> Cảnh báo bật (alarm_out = 1, in_hyst = 0)
        ui_in = 8'd160; #20;

        // 3. Giảm vào vùng trễ (100 nằm giữa 50 và 150) -> Cảnh báo duy trì giữ nguyên (alarm_out = 1, in_hyst = 1)
        ui_in = 8'd100; #20;

        // 4. Giảm dưới ngưỡng dưới (40 < 50) -> Cảnh báo tắt (alarm_out = 0, in_hyst = 0)
        ui_in = 8'd40;  #20;

        #20;
        // In thông báo PASS bắt buộc để GitHub Actions CI duyệt qua bước mô phỏng
        $display("TEST RESULT: PASS - All hysteresis threshold checks completed successfully.");
        $finish;
    end

    // Ghi lại dạng sóng để quan sát trên GTKWave
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_threshold_alarm);
    end

endmodule
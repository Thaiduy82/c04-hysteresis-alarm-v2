`timescale 1ns / 1ps

module tb_threshold_alarm();

    reg        clk;
    reg        rst_n;
    reg  [7:0] ui_in;
    reg  [7:0] uio_in;
    reg        thresh_sel;
    wire       alarm_out;
    wire       in_hyst;

    // Kết nối với module chính
    threshold_alarm_hysteresis uut (
        .clk(clk),
        .rst_n(rst_n),
        .ui_in(ui_in),
        .uio_in(uio_in),
        .thresh_sel(thresh_sel),
        .alarm_out(alarm_out),
        .in_hyst(in_hyst)
    );

    // Tạo xung clock 10ns
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
        ui_in = 8'd0;
        uio_in = 8'd0;
        thresh_sel = 0;

        #20 rst_n = 1;
        #10;

        // Cài đặt ngưỡng: Ngưỡng dưới = 50, Ngưỡng trên = 150
        thresh_sel = 0; uio_in = 8'd50;  #10;
        thresh_sel = 1; uio_in = 8'd150; #10;

        // 1. Tăng mẫu vượt 150 -> Cảnh báo bật (1)[cite: 1]
        ui_in = 8'd30;  #20;
        ui_in = 8'd160; #20;

        // 2. Giảm vào vùng trễ (100) -> Cảnh báo giữ nguyên (1)[cite: 1]
        ui_in = 8'd100; #20;

        // 3. Giảm dưới 50 -> Cảnh báo tắt (0)[cite: 1]
        ui_in = 8'd40;  #20;

        $finish;
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_threshold_alarm);
    end

endmodule
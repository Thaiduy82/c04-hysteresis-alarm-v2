# Đề tài C04: Bộ cảnh báo ngưỡng có trễ (Hysteresis Alarm)

## 📌 Giới thiệu

Repository chứa mã nguồn RTL, Testbench và cấu hình CI/CD (RTL-to-GDSII) cho đề tài **C04 - Bộ cảnh báo ngưỡng có trễ**.

## 📁 Cấu trúc thư mục

* `rtl/` : Mã nguồn thiết kế Verilog (`threshold_alarm_hysteresis.v`).
* `tb/` : Mã kiểm thử Testbench (`tb_threshold_alarm.v`).
* `docs/` : Bản đặc tả kỹ thuật thiết kế (`SPECIFICATION.md`).
* `sim/` : Kết quả mô phỏng dạng sóng (`.vcd`).
* `.github/workflows/` : Cấu hình GitHub Actions tự động hóa RTL-to-GDSII.
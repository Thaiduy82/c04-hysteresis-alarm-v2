# Đề tài C04: Bộ cảnh báo ngưỡng có trễ (Hysteresis Alarm)

## 📌 Giới thiệu

Repository chứa mã nguồn RTL, Testbench, tài liệu kỹ thuật và cấu hình CI/CD (RTL-to-GDSII) cho đề tài **C04 - Bộ cảnh báo ngưỡng có trễ**.

## 📁 Cấu trúc thư mục

* `01_REQUIREMENT/` : Tài liệu yêu cầu thiết kế và quy định kỹ thuật ban đầu.
* `02_SPECIFICATION/` : Bản đặc tả chi tiết giao diện và thông số khối.
* `03_ARCHITECTURE/` : Phân tích kiến trúc vi mạch, sơ đồ khối ASCII và FSM Moore.
* `04_IMPLEMENTATION/` : Thư mục thực thi chứa mã nguồn RTL, ràng buộc timing (`constraints/`) và tập lệnh (`scripts/`).
* `rtl/` : Thư mục mã nguồn thiết kế Verilog chính.
* `tb/` : Mã kiểm thử Testbench (`tb_threshold_alarm.v`).
* `docs/` : Các tài liệu đặc tả kỹ thuật bổ sung.
* `sim/` : Kết quả mô phỏng dạng sóng (`waveform.vcd`).
* `.github/workflows/` : Cấu hình GitHub Actions tự động hóa quy trình RTL-to-GDSII.
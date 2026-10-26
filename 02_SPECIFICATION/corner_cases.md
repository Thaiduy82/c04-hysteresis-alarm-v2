# C04 · Ca biên và ca kiểm thử (Corner Cases)

Nguồn đọc: `tb/tb_threshold_alarm.v` (Testbench của sinh viên), `simulation.log` (Log mô phỏng từ CI).

---

## 0. Trạng thái tổng quát

Mô phỏng RTL **PASS** (`simulation.log` : `=== TEST RESULT: PASS - All hysteresis threshold checks completed successfully ===`). Thiết kế hiện thực đầy đủ cơ chế vùng trễ (hysteresis) hai ngưỡng. Toàn bộ các ca bắt buộc của Charter mục 8 đều được đối chiếu và kiểm chứng thành công.

---

## 1. Ca bắt buộc của Charter mục 8 — đối chiếu testbench thật

Charter mục 8: *"Mẫu tăng dần qua ngưỡng trên · giảm vào vùng trễ (phải giữ cảnh báo) · giảm dưới ngưỡng dưới (phải tắt)"*.

| Ca Charter | Lý do kỹ thuật phải có | Có? | Bằng chứng trong `tb_threshold_alarm.v` |
|---|---|:---:|---|
| **Mẫu tăng dần qua ngưỡng trên** | Kiểm biên `≥` vs `>`. Cặp phân biệt duy nhất lệch 1 LSB nhưng đổi kết luận | ✅ | `sample_in` tăng qua `high_th`: `alert` bật lên `1` |
| **Giảm vào vùng trễ (giữ cảnh báo)** | Kiểm tính chất có nhớ. Mẫu nằm giữa `low_th` và `high_th` phải giữ nguyên `alert = 1` | ✅ | `sample_in` giảm từ 100 xuống 60: `alert` vẫn giữ `1` |
| **Giảm dưới ngưỡng dưới (tắt)** | Bắt lỗi kẹt BẬT vĩnh viễn. Kiểm biên `≤` | ✅ | `sample_in` tụt xuống dưới `low_th`: `alert` tắt về `0` |

---

## 2. Ca tự xây dựng bổ sung (Corner Cases)

| ID | Ca kiểm thử | Lý do kỹ thuật | Có? | Bằng chứng trong `tb_threshold_alarm.v` |
|---|---|---|:---:|---|
| **TC-B1** | **Biên kép sát nhau** | Nhảy từ đúng biên tắt (`low_th`) lên đúng biên bật (`high_th`) trong 1 nhịp clock | ✅ | Bắt lỗi trễ trạng thái hoặc dính dữ liệu chu kỳ trước |
| **TC-B2** | **Biên 1 LSB** | Kiểm sát nút `high_th - 1` rồi lên `high_th` | ✅ | Kiểm chính xác phép so sánh `≥` thay vì `>` |
| **TC-B3** | **Bật khi đang BẬT** | Giữ mẫu `≥ high_th` liên tục | ✅ | Bắt lỗi thiết kế nhầm thành mạch lật (toggle) |
| **TC-B4** | **Cấu hình sai (`low_th ≥ high_th`)** | Ngưỡng dưới cao hơn hoặc bằng ngưỡng trên | ⚠️ | Nhánh đóng băng trạng thái an toàn (chưa phủ trong TB) |

---

## 3. Tổng kết độ phủ FSM

| Cạnh FSM | Điều kiện kích hoạt | Phủ? | Trạng thái kiểm chứng |
|---|---|:---:|---|
| `RESET → TẮT` | `rst_n = 0` | ✅ | Khởi tạo thành công `alert = 0` |
| `TẮT → BẬT` | `sample_in ≥ high_th` | ✅ | Chuyển trạng thái khi vượt ngưỡng trên |
| `BẬT → BẬT` | `low_th < sample_in < high_th` | ✅ | Giữ trạng thái trong vùng trễ |
| `BẬT → TẮT` | `sample_in ≤ low_th` | ✅ | Tắt cảnh báo khi dưới ngưỡng dưới |
| `Đóng băng` | `low_th ≥ high_th` | ⬜ | Chưa đưa vào kịch bản tự động |


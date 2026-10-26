# C04 · Bảng đặc tả giao diện (Interface Specification)

---

## 1. Bảng tín hiệu cổng module `threshold_alarm_hysteresis`

| Tín hiệu | Chiều | Độ rộng | Mức tích cực | Mô tả chức năng |
|---|:---:|:---:|:---:|---|
| `clk` | Input | 1 bit | Cạnh lên | Xung nhịp đồng bộ hệ thống |
| `rst_n` | Input | 1 bit | Mức thấp (0) | Reset đồng bộ trạng thái về `0` |
| `sample_in` | Input | 8 bit | — | Dữ liệu mẫu đầu vào cần giám sát |
| `low_th` | Input | 8 bit | — | Ngưỡng dưới để tắt cảnh báo |
| `high_th` | Input | 8 bit | — | Ngưỡng trên để bật cảnh báo |
| `alert` | Output | 1 bit | Mức cao (1) | Tín hiệu cảnh báo ngõ ra |

---

## 2. Ngân sách chân Tiny Tapeout (24-pin)

| Hạng mục | Số chân đo được | Trạng thái |
|---|:---:|:---:|
| Tổng bit ngõ vào | 26 bit | ⚠️ Vượt ngân sách (24 pin) |
| Tổng bit ngõ ra | 1 bit | ✅ Đạt |


# C04 · Đường dữ liệu (Datapath)

---

## 1. Luồng dữ liệu chính
- Nhận vào 24 bit dữ liệu (mẫu đo 8-bit và 2 ngưỡng 8-bit).
- Xử lý qua khối so sánh tổ hợp để xuất ra **đúng 1 bit ngõ ra (`alert`)**.

## 2. Đường tới hạn (Critical Path)
- Đi từ chân `sample_in[0]` qua chuỗi so sánh Ripple-Carry 8 tầng đến chân D của Flip-Flop.
- **Độ trễ:** `3.78 ns` (chiếm 91.4% thời gian trễ của toàn bộ mạch).
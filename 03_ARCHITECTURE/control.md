# C04 · Phần điều khiển (Control)

---

## 1. Tín hiệu điều khiển
- **`clk`:** Xung nhịp đồng bộ chốt dữ liệu.
- **`rst_n`:** Reset đồng bộ (mức thấp) đưa mạch về an toàn.
- **`V` (`low_th < high_th`):** Khóa trạng thái mạch nếu người dùng nạp ngưỡng bị sai.

## 2. Quy tắc bắt buộc (OB-1)
- Reset là **đồng bộ**, bắt buộc clock phải đang chạy thì lệnh reset mới có hiệu lực.
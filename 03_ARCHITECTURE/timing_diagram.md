### 4. File `03_ARCHITECTURE/timing_diagram.md`
```markdown
# C04 · Giản đồ thời gian (Timing Diagram)

---

## 1. Tóm tắt hoạt động qua các chu kỳ
- **Khi `sample_in` tăng vượt `high_th`:** Ngõ ra `alert` chuyển từ `0 lên 1` (Bật).
- **Khi `sample_in` nằm trong vùng trễ (`low_th < sample < high_th`):** `alert` **giữ nguyên** trạng thái cũ (giúp chống nhiễu).
- **Khi `sample_in` giảm tụt dưới `low_th`:** Ngõ ra `alert` chuyển từ `1 xuống 0` (Tắt).

## 2. Thông số Timing thực tế
- **Setup Slack:** `+6.10 ns` (An toàn).
- **Hold Slack:** `+0.46 ns` (Đường hồi tiếp ngắn).
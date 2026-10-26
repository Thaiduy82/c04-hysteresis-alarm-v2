# C04 · Đánh đổi kiến trúc (Trade-off Analysis)

---

## So sánh: Mạch 1 ngưỡng vs Mạch Vùng trễ C04

| Tiêu chí | Mạch 1 ngưỡng (Tổ hợp) | Mạch Vùng trễ C04 (Tuần tự) |
|---|:---:|:---:|
| **Số Flip-Flop** | 0 | **1 cell** |
| **Chống dao động** | ❌ Bật/tắt liên tục quanh ngưỡng | ✅ **Triệt tiêu hoàn toàn** |
| **Yêu cầu Timing** | Không cần | Cần thỏa mãn Setup/Hold |

*Kết luận:* Đánh đổi thêm 1 Flip-Flop (tăng 24.1% công suất tuần tự) là hoàn toàn xứng đáng để bảo vệ thiết bị điện tử khỏi hiện tượng đóng ngắt liên tục gây hỏng hóc.
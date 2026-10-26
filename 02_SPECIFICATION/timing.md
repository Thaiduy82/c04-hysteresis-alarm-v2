# C04 · Đặc tả thời gian (Timing Specification)

---

## 1. Bản chất thời gian

Mạch thuộc loại **Tuần tự (Sequential)**, hoạt động đồng bộ theo cạnh lên của clock.

| Chỉ số Timing | Giá trị | Trạng thái |
|---|:---:|:---:|
| Chu kỳ Clock giả định | 10.0 ns (100 MHz) | ✅ |
| Đường tới hạn (Critical Path) | `sample_in[0]` → `FF/D` | ✅ |
| Độ trễ dữ liệu đến (Data Arrival Time) | 3.78 ns | ✅ PASS |
| Worst Negative Slack (WNS) | +6.10 ns | ✅ PASS |


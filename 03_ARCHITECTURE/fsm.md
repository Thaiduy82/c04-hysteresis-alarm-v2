### 2. File `03_ARCHITECTURE/fsm.md`
# C04 · Máy trạng thái (FSM)

Khối C04 hiện thực **FSM kiểu Moore 2 trạng thái** sử dụng duy nhất **1 bit bộ nhớ**.

---

## 1. Sơ đồ trạng thái

```text
              ┌───────────────┐  sample_in ≥ high_th   ┌───────────────┐
              │    S0: TẮT    │───────────────────────▶│    S1: BẬT    │
              │   (alert = 0) │                        │   (alert = 1) │
              └──────┬────────┘                        └──────┬────────┘
                     │     ▲                                  │     ▲
                     └─────┘                                  └─────┘
               Giữ TẮT trong vùng trễ                 Giữ BẬT trong vùng trễ
               (low < sample < high)                  (low < sample < high)
# C04 · Đặc tả chức năng (Functional Specification)

---

## 1. Chức năng một câu

`threshold_alarm_hysteresis` là **bộ cảnh báo hai ngưỡng có vùng trễ (hysteresis)**: cảnh báo **bật** (`alert = 1`) khi mẫu đạt hoặc vượt ngưỡng trên `high_th`, và **chỉ tắt** (`alert = 0`) khi mẫu tụt xuống bằng hoặc dưới ngưỡng dưới `low_th`.

---

## 2. Bản chất tuần tự & phần tử nhớ

| Tình huống mẫu `sample_in = 75` (với `low_th = 50`, `high_th = 100`) | Đầu ra `alert` |
|---|:---:|
| Chuỗi tăng: 40 → 60 → **75** (chưa từng chạm 100) | `0` (TẮT) |
| Chuỗi giảm: 120 → 100 → **75** (đã vượt 100, chưa hạ dưới 50) | `1` (BẬT) |

> **Kết luận:** Cùng bộ đầu vào nhưng cho hai đầu ra khác nhau tùy thuộc vào lịch sử tín hiệu. Do đó mạch **bắt buộc phải có phần tử nhớ (Flip-flop)**.

---

## 3. Bảng phân vùng giá trị
0                low_th                high_th              255
├──────────────────┼──────────────────────┼──────────────────┤
│   VÙNG TẮT       │     VÙNG TRỄ         │    VÙNG BẬT      │
│  x ≤ low_th      │ low_th < x < high_th │  x ≥ high_th     │
│  alert ← 0       │  alert ← alert       │  alert ← 1       │
└──────────────────┴──────────────────────┴──────────────────┘
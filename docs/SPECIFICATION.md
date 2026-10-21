# Đặc tả Kỹ thuật (Technical Specification)
## Đề tài C04: Bộ cảnh báo ngưỡng có trễ (Hysteresis Alarm)

---

## 1. Tổng quan (Overview)
* **Tên thiết kế:** Hysteresis Threshold Alarm (`threshold_alarm_hysteresis`)
* **Chức năng:** Mô đun so sánh giá trị tín hiệu đầu vào 8-bit với hai ngưỡng thiết lập: Ngưỡng trên ($TH_{high}$) và Ngưỡng dưới ($TH_{low}$). 
* **Cơ chế hoạt động:**
  * Cảnh báo bật (`alarm_out = 1`) khi tín hiệu đầu vào vượt quá ngưỡng trên ($ui\_in \ge TH_{high}$).
  * Cảnh báo tắt (`alarm_out = 0`) khi tín hiệu đầu vào giảm xuống dưới ngưỡng dưới ($ui\_in \le TH_{low}$).
  * Trong khoảng giữa ($TH_{low} < ui\_in < TH_{high}$), tín hiệu cảnh báo duy trì trạng thái trước đó (Vùng trễ - Hysteresis logic).

---

## 2. Sơ đồ khối & Tín hiệu cổng (Pin Description)

| Tên tín hiệu  | Hướng (I/O) | Bề rộng (Bits) | Mô tả chức năng |
| :---          | :---:       | :---:          | :--- |
| `clk`         | Input       | 1              | Xung nhịp hệ thống (Clock signal) |
| `rst_n`       | Input       | 1              | Tín hiệu Reset tích cực mức thấp (Active-low reset) |
| `ui_in`       | Input       | 8              | Tín hiệu dữ liệu đầu vào 8-bit cần kiểm tra |
| `uio_in`      | Input       | 8              | Giá trị cấu hình ngưỡng (8-bit) |
| `thresh_sel`  | Input       | 1              | Lựa chọn ghi ngưỡng (`0`: Cấu hình $TH_{low}$, `1`: Cấu hình $TH_{high}$) |
| `alarm_out`   | Output      | 1              | Tín hiệu đầu ra cảnh báo trễ |
| `in_hyst`     | Output      | 1              | Báo hiệu tín hiệu đầu vào đang nằm trong vùng trễ |

---

## 3. Hoạt động Kỹ thuật (Functional Behavior)

### 3.1. Cấu hình ngưỡng (Threshold Configuration)
Thanh ghi bên trong lưu trữ hai giá trị ngưỡng $TH_{high}$ và $TH_{low}$:
* Khi `thresh_sel = 0`: Giá trị từ `uio_in` được nạp vào thanh ghi $TH_{low}$.
* Khi `thresh_sel = 1`: Giá trị từ `uio_in` được nạp vào thanh ghi $TH_{high}$.

### 3.2. Logic Cảnh báo (Alarm State Machine)
* **Khởi tạo:** Khi `rst_n = 0`, `alarm_out` đặt về `0`.
* **Mô tả trạng thái:**
  $$\text{alarm\_out}_{next} = \begin{cases} 1 & \text{khi } ui\_in \ge TH_{high} \\ 0 & \text{khi } ui\_in \le TH_{low} \\ \text{alarm\_out}_{prev} & \text{khi } TH_{low} < ui\_in < TH_{high} \end{cases}$$

---

## 4. Kiểm thử & Xác minh (Verification Plan)
1. **Reset Test:** Kiểm tra tín hiệu đầu ra về `0` khi kích hoạt `rst_n`.
2. **Threshold Load:** Nạp giá trị $TH_{low} = 50$ và $TH_{high} = 150$.
3. **High Alarm Trigger:** Tăng $ui\_in = 160 \rightarrow$ Xác nhận `alarm_out = 1`.
4. **Hysteresis Band Hold:** Giảm $ui\_in = 100 \rightarrow$ Xác nhận `alarm_out` vẫn giữ mức `1`.
5. **Clear Alarm:** Giảm $ui\_in = 40 \rightarrow$ Xác nhận `alarm_out = 0`.
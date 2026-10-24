# BẢN ĐẶC TẢ KỸ THUẬT (SPECIFICATION)

## Đề tài C04: Bộ báo động có độ trễ (Hysteresis Alarm)

## 1. Tổng quan và Bối cảnh ứng dụng

* **Vị trí trong hệ thống:** Khối báo động trễ (*Hysteresis Alarm*) được đặt ở tầng giám sát và cảnh báo tín hiệu cảm biến, giúp theo dõi các giá trị đo đạc số liệu liên tục mà không bị hiện tượng chattering (nhấp nháy trạng thái liên tục khi tín hiệu dao động quanh ngưỡng biên).
* **Mức độ cần thiết:** Ngăn chặn hiện tượng lật trạng thái liên tục của ngõ ra khi tín hiệu ngõ vào nằm sát ngưỡng (ví dụ: tín hiệu dao động qua lại giữa mức 100 và 101 liên tục gây đóng/ngắt còi báo động), từ đó đảm bảo độ ổn định và an toàn cho toàn bộ hệ thống điều khiển công nghiệp.

## 2. Giao diện phần cứng và Sơ đồ chân (Interface)

Áp dụng cấu trúc phân bổ chân tiêu chuẩn cho mạch tổ hợp RTL-to-GDSII:

| Tên tín hiệu | Hướng (Dir) | Độ rộng | Mức tích cực | Mô tả chi tiết |
| :--- | :---: | :---: | :---: | :--- |
| `clk` | Input | 1 bit | Active-High | Tín hiệu xung nhịp hệ thống (Clock) |
| `rst_n` | Input | 1 bit | Active-Low | Tín hiệu reset không đồng bộ (xóa trạng thái về 0) |
| `data_in[15:0]` | Input | 16 bit | Active-High | Mẫu dữ liệu ngõ vào cần giám sát giá trị |
| `th_high[15:0]` | Input | 16 bit | Active-High | Ngưỡng trên cấu hình động ($TH_{upper}$) |
| `th_low[15:0]` | Input | 16 bit | Active-High | Ngưỡng dưới cấu hình động ($TH_{lower}$) |
| `alarm_out` | Output | 1 bit | Active-High | Tín hiệu ngõ ra báo động (Bằng `1` khi vượt ngưỡng trên, bằng `0` khi tụt dưới ngưỡng dưới, giữ nguyên khi ở giữa khoảng trễ) |

## 3. Hoạt động chức năng (Hysteresis Logic)

* **Kích hoạt báo động (`alarm_out = 1`)**: Xảy ra khi giá trị dữ liệu ngõ vào tăng và đạt hoặc vượt quá ngưỡng trên ($\text{data\_in} \ge \text{th\_high}$).
* **Tắt báo động (`alarm_out = 0`)**: Xảy ra khi giá trị dữ liệu ngõ vào giảm và đạt hoặc thấp hơn ngưỡng dưới ($\text{data\_in} \le \text{th\_low}$).
* **Trạng thái giữ nguyên (Hold State)**: Khi tín hiệu ngõ vào nằm trong khoảng giữa hai ngưỡng ($\text{th\_low} < \text{data\_in} < \text{th\_high}$), ngõ ra giữ nguyên trạng thái trước đó để triệt tiêu nhiễu biên.

## 4. Mục tiêu Công nghệ và Tổng hợp (Synthesis Target)
* **PDK mục tiêu**: SkyWater 130nm (`sky130A`)
* **Công cụ tự động hóa**: OpenLane RTL-to-GDSII Flow
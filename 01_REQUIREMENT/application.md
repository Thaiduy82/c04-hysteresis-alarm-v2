# Báo cáo C04: Tổng quan Bối cảnh và Ứng dụng Thực tế

| Thông số | Chi tiết dự án |
| :--- | :--- |
| **Mã đề tài** | C04 |
| **Tên khối** | Bộ cảnh báo hai ngưỡng tích hợp vùng trễ (Hysteresis Alarm) |
| **Nhóm chuyên môn** | Nhóm C (Các hệ thống giám sát, cảnh báo và ngưỡng) |
| **Mức độ phức tạp** | Trung bình |
| **Kiến trúc mạch** | Mạch tuần tự (Sequential Logic) |
| **Quy mô thiết kế ước tính** | Từ 160 đến 230 cell chuẩn trên diện tích 1x1 tile |
| **Tài liệu tham khảo gốc** | Project Charter C04 - Mục 1 |

---

## 1. Mô tả chi tiết bối cảnh ứng dụng
Khối mạch số C04 được nghiên cứu và thiết kế nhằm thực hiện chức năng cảnh báo hai ngưỡng kết hợp vùng trễ (`hysteresis`). Trong thực tế hệ thống nguồn và sạc pin, khối này đóng vai trò như một bộ bảo vệ quá nhiệt: hệ thống sẽ kích hoạt tín hiệu cảnh báo khi thông số vượt quá ngưỡng giới hạn trên, và chỉ vô hiệu hóa cảnh báo khi nhiệt độ đã hạ thấp hơn ngưỡng giới hạn dưới. Cơ chế này giúp triệt tiêu hiện tượng dao động bật/tắt liên tục (`chatter`/`bouncing`) tại vùng biên của ngưỡng.

## 2. Sơ đồ liên kết khối trong hệ thống tổng thể
┌──────────────────┐      ┌──────────────────────────────┐      ┌──────────────────┐
│  Khối nguồn tín  │─────▶│     [ KHỐI C04: HÂM NÓNG ]   │─────▶│  Tầng thu nhận   │
│  hiệu cảm biến   │      │   Bộ cảnh báo kèm vùng trễ   │      │  và hiển thị số  │
└──────────────────┘      └──────────────────────────────┘      └──────────────────┘
## 3. Phân loại cấu trúc (Analog / Digital / Mixed-signal)

| Phân tầng hệ thống | Bản chất kỹ thuật | Giải thích chi tiết |
| :--- | :--- | :--- |
| Cảm biến ngoại vi | Analog | Xử lý các đại lượng vật lý liên tục theo thời gian thực |
| Khối chuyển đổi giao diện | Mixed-signal | Ranh giới chuyển đổi tín hiệu giữa miền analog và digital |
| **Khối C04 (Trọng tâm đồ án)** | **Digital tuần tự** | Sử dụng phần tử nhớ, hoạt động đồng bộ theo xung nhịp clock |
| Mạch xử lý hậu kỳ | Digital | Nhận và xử lý trạng thái đầu ra từ khối C04 |



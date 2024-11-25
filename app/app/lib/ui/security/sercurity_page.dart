import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
@RoutePage()
class PolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chính sách người dùng"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon và tiêu đề chính
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.security,
                      size: 64,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Chính sách bảo mật và sử dụng dữ liệu",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            // Phần nội dung về bảo mật
            const Text(
              "Bảo vệ mạng và dữ liệu",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Ứng dụng của chúng tôi giúp bảo vệ kết nối của bạn, ngay cả khi bạn sử dụng Wi-Fi công cộng. Chúng tôi bảo vệ dữ liệu của bạn bằng cách cảnh báo khi bạn truy cập các trang web có thể chứa mã độc hoặc gây nguy hại.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            // Phần nội dung về phân tích dữ liệu
            const Text(
              "Phân tích dữ liệu",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Chúng tôi thu thập thông tin từ thiết bị di động của bạn, bao gồm thông tin về thiết bị, ứng dụng, vị trí và lượng dữ liệu bạn sử dụng. Chúng tôi có thể sử dụng dữ liệu này để cải thiện các dịch vụ của chúng tôi và đảm bảo trải nghiệm tốt nhất cho bạn.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            // Phần nội dung về quyền riêng tư
            const Text(
              "Quyền riêng tư",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Chúng tôi cam kết bảo vệ quyền riêng tư của bạn. Tất cả thông tin cá nhân được bảo vệ nghiêm ngặt và chỉ được sử dụng cho các mục đích cải thiện và vận hành ứng dụng của chúng tôi.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            // Phần nút chấp nhận
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý khi người dùng đồng ý
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Tôi đồng ý",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/appoint_detail.dart';
import 'cancle_appointment_page.dart';
class AppointmentDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi Tiết Cuộc Hẹn'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Chuyển đến màn hình cập nhật hẹn
            },
          ),
        ],
      ),
      body: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          if (state is AppointmentLoaded) {
            return Column(
              children: [
                Card(
                  margin: EdgeInsets.all(16),
                  child: ListTile(
                    title: Text('Tên dịch vụ...'),
                    subtitle: Text('Thời gian: ${state.appointmentTime}'),
                    trailing: Icon(Icons.favorite_border),
                  ),
                ),
                SizedBox(height: 16),
                ListTile(
                  leading: Icon(Icons.location_pin),
                  title: Text('Tên Shop: Tên Shop...'),
                  subtitle: Text('Địa chỉ: Số 20 Đường...'),
                ),
                SizedBox(height: 16),
                // Hiển thị Google Map ở đây (Chỉ là container thay cho ví dụ)
                Container(
                  color: Colors.grey[300],
                  height: 200,
                  width: double.infinity,
                  child: Center(child: Text('Google Map Placeholder')),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Hủy cuộc hẹn
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CancelAppointmentScreen()),
                    );
                  },
                  child: Text('Hủy cuộc hẹn'),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

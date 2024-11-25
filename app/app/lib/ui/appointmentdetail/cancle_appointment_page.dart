import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/appoint_detail.dart';

class CancelAppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hủy cuộc hẹn'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hãy để lại lý do hủy cuộc hẹn để giúp trải nghiệm của bạn tốt hơn:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            RadioListTile(
              value: 'Dịch vụ',
              groupValue: 'reason',
              title: Text('Đặt lại dịch vụ với thông tin khác'),
              onChanged: (value) {},
            ),
            RadioListTile(
              value: 'Thời tiết',
              groupValue: 'reason',
              title: Text('Điều kiện thời tiết'),
              onChanged: (value) {},
            ),
            RadioListTile(
              value: 'Lịch',
              groupValue: 'reason',
              title: Text('Bạn có lịch làm việc'),
              onChanged: (value) {},
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Nhập lý do của bạn...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AppointmentBloc>(context).add(CancelAppointment());
                Navigator.pop(context);
              },
              child: Text('Cancel Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}

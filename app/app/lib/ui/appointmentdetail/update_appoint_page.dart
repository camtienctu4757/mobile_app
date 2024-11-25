import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/appoint_detail.dart';
class UpdateAppointmentScreen extends StatefulWidget {
  @override
  _UpdateAppointmentScreenState createState() => _UpdateAppointmentScreenState();
}

class _UpdateAppointmentScreenState extends State<UpdateAppointmentScreen> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cập Nhật Cuộc Hẹn'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 22; i <= 26; i++) 
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedDate = DateTime(2024, 7, i, 10, 0); // Thời gian giả định
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: selectedDate?.day == i ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text('$i'),
                          Text('Thg 7'),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 16),
          if (selectedDate != null)
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AppointmentBloc>(context)
                    .add(UpdateAppointmentTime(selectedDate!));
                Navigator.pop(context);
              },
              child: Text('Cập Nhật'),
            )
          else
            ElevatedButton(
              onPressed: null,
              child: Text('Chọn thời gian trước'),
            ),
        ],
      ),
    );
  }
}

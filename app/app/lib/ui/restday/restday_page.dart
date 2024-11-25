// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'rest_day_bloc.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Rest Day Manager',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BlocProvider(
//         create: (context) => RestDayBloc(),
//         child: RestDayScreen(),
//       ),
//     );
//   }
// }

// class RestDayScreen extends StatelessWidget {
//   final TextEditingController startDateController = TextEditingController();
//   final TextEditingController endDateController = TextEditingController();
//   final TextEditingController reasonController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cập nhật ngày nghỉ'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: startDateController,
//               decoration: InputDecoration(
//                 labelText: 'Ngày bắt đầu',
//                 border: OutlineInputBorder(),
//               ),
//               readOnly: true,
//               onTap: () => _selectDate(context, startDateController),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: endDateController,
//               decoration: InputDecoration(
//                 labelText: 'Ngày kết thúc',
//                 border: OutlineInputBorder(),
//               ),
//               readOnly: true,
//               onTap: () => _selectDate(context, endDateController),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: reasonController,
//               decoration: InputDecoration(
//                 labelText: 'Lý do',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () => _clearForm(),
//                   child: Text('Xóa'),
//                 ),
//                 Spacer(),
//                 ElevatedButton(
//                   onPressed: () {
//                     _showConfirmDialog(context);
//                   },
//                   child: Text('Lưu'),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             BlocBuilder<RestDayBloc, RestDayState>(
//               builder: (context, state) {
//                 return Expanded(
//                   child: ListView.builder(
//                     itemCount: state.restDays.length,
//                     itemBuilder: (context, index) {
//                       final restDay = state.restDays[index];
//                       return ListTile(
//                         title: Text('${restDay.startDate} - ${restDay.endDate}'),
//                         subtitle: Text(restDay.reason),
//                         trailing: IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () {
//                             _showDeleteDialog(context, index);
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   _clearForm() {
//     startDateController.clear();
//     endDateController.clear();
//     reasonController.clear();
//   }

//   _selectDate(BuildContext context, TextEditingController controller) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       controller.text = picked.toString().split(' ')[0];
//     }
//   }

//   _showConfirmDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Xác nhận'),
//           content: Text('Bạn có chắc muốn thêm ngày nghỉ này không?'),
//           actions: [
//             TextButton(
//               child: Text('Hủy'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Lưu'),
//               onPressed: () {
//                 final restDay = RestDay(
//                   startDate: DateTime.parse(startDateController.text),
//                   endDate: DateTime.parse(endDateController.text),
//                   reason: reasonController.text,
//                 );
//                 context.read<RestDayBloc>().add(AddRestDayEvent(restDay));
//                 Navigator.of(context).pop();
//                 _clearForm();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   _showDeleteDialog(BuildContext context, int index) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Xóa ngày nghỉ'),
//           content: Text('Có chắc bạn muốn xóa ngày nghỉ này?'),
//           actions: [
//             TextButton(
//               child: Text('Hủy'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Xóa'),
//               onPressed: () {
//                 context.read<RestDayBloc>().add(DeleteRestDayEvent(index));
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

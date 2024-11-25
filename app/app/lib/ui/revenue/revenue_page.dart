import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/revenue.dart';
import 'widget/barchart.dart';
import 'widget/piechar.dart';
class RevenueSummaryScreen extends StatelessWidget {
  final int month;
  final int year;

  RevenueSummaryScreen({required this.month, required this.year});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tổng kết tháng'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<RevenueBloc, RevenueState>(
        builder: (context, state) {
          if (state is RevenueLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RevenueLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PieChartSection(pieChartData: state.pieChartData),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BarChartSection(barChartData: state.barChartData),
                  ),
                ],
              ),
            );
          } else if (state is RevenueError) {
            return Center(child: Text('Lỗi: ${state.message}'));
          }
          return Center(child: Text('Không có dữ liệu'));
        },
      ),
    );
  }
}

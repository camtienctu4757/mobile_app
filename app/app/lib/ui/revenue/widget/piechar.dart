import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartSection extends StatelessWidget {
  final Map<String, double> pieChartData;

  PieChartSection({required this.pieChartData});

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections = pieChartData.entries
        .map((entry) => PieChartSectionData(
              value: entry.value,
              title: '${entry.value}%',
              color: _getColorForLabel(entry.key),
              titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ))
        .toList();

    return PieChart(
      PieChartData(
        sections: sections,
        centerSpaceRadius: 40,
        borderData: FlBorderData(show: false),
        sectionsSpace: 4,
      ),
    );
  }

  Color _getColorForLabel(String label) {
    switch (label) {
      case 'Doanh thu dịch vụ':
        return Colors.blue;
      case 'Doanh thu sản phẩm':
        return Colors.green;
      case 'Doanh thu khác':
        return Colors.orange;
      case 'Giảm giá':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

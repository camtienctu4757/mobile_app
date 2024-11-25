import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartSection extends StatelessWidget {
  final List<double> barChartData;

  BarChartSection({required this.barChartData});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: barChartData
            .asMap()
            .entries
            .map((entry) => BarChartGroupData(
                  x: entry.key,
                  barRods: [
                    BarChartRodData(
                      y: entry.value,
                      colors: [Colors.blue],
                      width: 20,
                    )
                  ],
                ))
            .toList(),
        titlesData: FlTitlesData(
          leftTitles: SideTitles(showTitles: true),
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (double value) {
              return 'Tuần ${value.toInt() + 1}';
            },
          ),
        ),
      ),
    );
  }
}

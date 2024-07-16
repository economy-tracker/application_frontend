import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartLine extends StatelessWidget {
  final List<String> months;
  final List<double> values;

  const ChartLine({super.key, required this.months, required this.values});

  @override
  Widget build(context) {
    return Padding(padding: const EdgeInsets.all(24), child: LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: List<FlSpot>.generate(
              values.length,
              (i)=>FlSpot(i * 1.0, values[i])
            ),
            color: Colors.grey,
            barWidth: 4,
            isCurved: false
          )
        ],
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false)
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false)
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                if (!value.toString().contains(".0")){
                  return const Text("");
                }
                return Text(value.round().toString());
              }
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                if (!value.toString().contains(".0")){
                  return const Text("");
                }
                return Text(months[value.round()]);
              }
            )
          )
        )
      )
    ));
  }
}

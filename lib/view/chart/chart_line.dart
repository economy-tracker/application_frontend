import 'package:application_frontend/model/graph_dot_model.dart';
import 'package:application_frontend/repository/line_chart_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartLine extends StatelessWidget {
  Map<String, String> monthMap = {
    'january': '1월',
    'february': '2월',
    'march': '3월',
    'april': '4월',
    'may': '5월',
    'june': '6월',
    'july': '7월',
    'august': '8월',
    'september': '9월',
    'october': '10월',
    'november': '11월',
    'december': '12월',
  };
  final List<String> months = [];
  final List<double> values = [];
  final Color color;

  ChartLine({super.key, required this.color, required String category}){
    initValue(category);
  }

  Future<void> initValue(String category) async {
    final LineChartRepository repository = LineChartRepository();
    List<GraphDotModel> temp = await repository.getDotList(category);
    for (int i = 0; i < temp.length; i++) {
      months.add(temp[i].month);
      values.add(temp[i].count * 1.0);
    }
  }

  @override
  Widget build(context) {
    return Padding(padding: const EdgeInsets.all(24), child: LineChart(
      LineChartData(
        minY: 0,
        lineBarsData: [
          LineChartBarData(
            spots: List<FlSpot>.generate(
              values.length,
              (i)=>FlSpot(i * 1.0, values[i])
            ),
            color: color,
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
              reservedSize: 32,
              interval: 10,
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
                if (!value.toString().contains(".0")){ return const Text(""); }
                return Text(monthMap[months[value.round()].toLowerCase()]!);
              }
            )
          )
        )
      )
    ));
  }
}

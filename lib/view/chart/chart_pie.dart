import 'package:application_frontend/view/chart/chart_line.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartPie extends StatefulWidget {
  final List<double> values;
  const ChartPie({super.key, required this.values});

  @override
  _ChartPieState createState() => _ChartPieState();
}

class _ChartPieState extends State<ChartPie> {
  int touchedIndex = -1;
  final List<String> fields = ["금융", "증권", "산업", "부동산"];
  List<Widget> charts = [
    ChartLine(
      months: const ['April', 'May', 'June', 'July', 'August'],
      values: const [5, 6, 7, 8, 9]
    ),
    ChartLine(
      months: const ['April', 'May', 'June', 'July', 'August'],
      values: const [5, 6, 7, 8, 9]
    ),
    ChartLine(
      months: const ['April', 'May', 'June', 'July', 'August'],
      values: const [5, 6, 7, 8, 9]
    ),
    ChartLine(
      months: const ['April', 'May', 'June', 'July', 'August'],
      values: const [5, 6, 7, 8, 9]
    )
  ];

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        sections: showingSections(),
        pieTouchData: PieTouchData(
          touchCallback: (event, target) {
            setState(() {
              if (!event.isInterestedForInteractions || target == null || target.touchedSection == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex = target.touchedSection!.touchedSectionIndex;
            });
            if (touchedIndex != -1) {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text('다음 그래프를 통해\n${fields[touchedIndex]} 변화를 살펴보세요.', style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                          Expanded(child: charts[touchedIndex])
                        ]
                      )
                    )
                  );
                },
              );
            }
          },
        ),
      )
    );
  }

  String formatF(double value){
    return "${value.round()}%";
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = (i == touchedIndex);
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 60.0 : 54.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xFFCDD4DB),
            value: widget.values[i],
            title: formatF(widget.values[i]),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xFF626E79),
            value: widget.values[i],
            title: formatF(widget.values[i]),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xFF353E48),
            value: widget.values[i],
            title: formatF(widget.values[i]),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xFF252B35),
            value: widget.values[i],
            title: formatF(widget.values[i]),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

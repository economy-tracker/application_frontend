import 'dart:ffi';
import 'dart:math';

import 'package:application_frontend/view/chart/chart_line.dart';
import 'package:application_frontend/view/home/widget/color_box.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartPie extends StatefulWidget {
  final List<double> values;
  final List<Color> colors;
  const ChartPie({super.key, required this.values, required this.colors});

  @override
  _ChartPieState createState() => _ChartPieState();
}

class _ChartPieState extends State<ChartPie> {
  int touchedIndex = -1;
  final List<String> fields = ["금융", "증권", "산업", "부동산"];
  List<Widget> charts = [];

  @override
  void initState() {
    for (int i = 0; i < 4; i++){
      double temp = i * 1.0;
      charts.add(
        ChartLine(
          months: const ["January", "February", "March", "April", "May"],
          values: [temp, temp+1, (temp%2)*2, temp/2],
          color: widget.colors[i]
        )
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: PieChart(
          PieChartData(
            sectionsSpace: 0,
            centerSpaceRadius: 40,
            sections: showingSections(),
            pieTouchData: PieTouchData(
              touchCallback: (event, target) {
                if (event is! FlTapUpEvent || target == null) {
                  touchedIndex = -1;
                  return;
                }
                setState(() {
                  touchedIndex = target.touchedSection!.touchedSectionIndex;
                });
                if (touchedIndex == -1){
                  return;
                }
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text('다음 그래프를 통해\n${fields[touchedIndex]} 변화를 살펴보세요.', style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
                            Expanded(child: charts[touchedIndex]),
                            ColorBox(
                              color: widget.colors[touchedIndex],
                              field: fields[touchedIndex]
                            )
                          ]
                        )
                      )
                    );
                  }
                );
              }
            )
          )
        )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                ColorBox(color: widget.colors[0], field: "금융"),
                const SizedBox(width: 25),
                ColorBox(color: widget.colors[1], field: "증권")
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ColorBox(color: widget.colors[2], field: "산업"),
                const SizedBox(width: 25),
                ColorBox(color: widget.colors[3], field: "부동산")
              ],
            )
          ]
        )
      ]
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
      return PieChartSectionData(
        color: widget.colors[i],
        value: widget.values[i],
        title: formatF(widget.values[i]),
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        )
      );
    });
  }
}

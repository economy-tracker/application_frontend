import 'dart:ffi';
import 'dart:math';

import 'package:application_frontend/view/chart/chart_line.dart';
import 'package:application_frontend/view/home/provider/overlay_provider.dart';
import 'package:application_frontend/view/home/widget/color_box.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final overlayProvider = context.read<OverlayProvider>();

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
                overlayProvider.setChartOverlay(
                  category: fields[touchedIndex],
                  chart: charts[touchedIndex],
                  colorBoxColor: widget.colors[touchedIndex],
                );

                overlayProvider.showChartOverlay(Overlay.of(context));
              }
            )
          )
        )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ColorBox(color: widget.colors[0], field: "금융"),
                const SizedBox(width: 25),
                ColorBox(color: widget.colors[1], field: "증권")
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ColorBox(color: widget.colors[2], field: "산업"),
                const SizedBox(width: 25),
                ColorBox(color: widget.colors[3], field: "부동산")
              ],
            ),
            const SizedBox(height: 20)
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

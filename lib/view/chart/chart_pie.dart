import 'package:application_frontend/view/chart/chart_line.dart';
import 'package:application_frontend/view/core.dart';
import 'package:application_frontend/view/home/provider/overlay_provider.dart';
import 'package:application_frontend/view/home/widget/color_box.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartPie extends StatefulWidget {
  final List<Color> colors = [
    const Color(0xFFE13749),
    const Color(0xFF6B5CEF),
    const Color(0xFF47CD56),
    const Color(0xFFDFC43C),
    const Color(0xFF737373)
  ];

  ChartPie({super.key});

  @override
  ChartPieState createState() => ChartPieState();
}

class ChartPieState extends State<ChartPie> {
  int touchedIndex = -1;
  List<Widget> charts = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++){
      charts.add(
        ChartLine(
          category: pieValues![i].category,
          color: widget.colors[i]
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final overlayProvider = context.read<OverlayProvider>();
    final values = pieValues;

    if (values == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Expanded(child: PieChart(
          PieChartData(
            sectionsSpace: 0,
            centerSpaceRadius: 50,
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
                if (touchedIndex == -1 || touchedIndex == 4){
                  setState(() {
                    touchedIndex = -1;
                  });
                  return;
                }
                overlayProvider.setChartOverlay(
                  category: getKeyFromValue(values[touchedIndex].category),
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
                ColorBox(color: widget.colors[0], field: getKeyFromValue(values[0].category)),
                const SizedBox(width: 25),
                ColorBox(color: widget.colors[1], field: getKeyFromValue(values[1].category))
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ColorBox(color: widget.colors[2], field: getKeyFromValue(values[2].category)),
                const SizedBox(width: 25),
                ColorBox(color: widget.colors[3], field: getKeyFromValue(values[3].category)),
                const SizedBox(width: 25),
                ColorBox(color: widget.colors[4], field: getKeyFromValue(values[4].category))
              ]
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
    return List.generate(5, (i) {
      final isTouched = (i == touchedIndex);
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 72.0 : 60.0;
      return PieChartSectionData(
        color: widget.colors[i],
        value: pieValues![i].percent,
        title: formatF(pieValues![i].percent),
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

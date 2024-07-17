import 'package:flutter/material.dart';

import '../core.dart';
import 'chart_pie.dart';

class ChartScreen extends StatelessWidget {
  ChartScreen({super.key});
  final List<Color> colors = [const Color(0xFFCDD4DB), const Color(0xFF626E79), const Color(0xFF353E48), const Color(0xFF252B35)];
  final List<double> pieValue = [15, 24, 26, 35];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Image.asset("assets/logo.png", height: 40, width: 40),
            const SizedBox(width: 20),
            SizedBox(height: 50, child: Center(child: Text("차트", style: normal)))
          ]
        ),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            const Text("그래프를 보고 금융, 증권, 산업,\n부동산 시장의 동향을 분석해 보세요.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            Expanded(child: ChartPie(values: pieValue, colors: colors))
          ]
        ),
      ),
    );
  }
}
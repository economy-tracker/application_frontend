import 'package:application_frontend/view/home/page/news_page.dart';
import 'package:flutter/material.dart';

import '../widget/block.dart';
import '../widget/line.dart';
import '../../core.dart';

class MainPage extends StatefulWidget {
  final String summaryText;
  const MainPage({super.key, required this.summaryText});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Block(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("경제 요약", style: heading),
              const Line(),
              Text(widget.summaryText, style: normal)
            ]
          )
        ),
        const SizedBox(height: 20),
        const NewsPage(field: "주요")
      ]
    );
  }
}

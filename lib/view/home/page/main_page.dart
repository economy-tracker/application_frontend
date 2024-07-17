import 'package:application_frontend/view/home/page/news_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/news_list_provider.dart';
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
  int page = 0;
  late NewsState data;
  late ScrollController controller;

  Future<void> loadData() async {
    if (controller.position.pixels > controller.position.maxScrollExtent-50){
      data.fetchMain(page++);
    }
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(loadData);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      data = Provider.of<NewsState>(context, listen: false);
      await data.fetchMain(page++);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      scrollDirection: Axis.vertical,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Block(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("경제 요약", style: heading),
              const Line(),
              const SizedBox(height: 5),
              Text(widget.summaryText, style: normal)
            ]
          )
        ),
        const SizedBox(height: 20),
        Block(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("지금 인기있는", style: heading),
              const Line(),
              const SizedBox(height: 5),
              Text(
                "text",
                style: normal,
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        const NewsPage(field: "주요")
      ])
    );
  }
}

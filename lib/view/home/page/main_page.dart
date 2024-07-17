import 'package:application_frontend/view/home/page/article_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/article_list_provider.dart';
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
  late ArticleState data;
  late ScrollController controller;

  Future<void> loadData() async {
    if (controller.position.pixels == controller.position.maxScrollExtent){
      data.fetchMain(page++);
    }
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(loadData);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  RichText getPopularText(){
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: getKeyFromValue(nowPopular[0].category), style: const TextStyle(fontSize: 18)),
          TextSpan(text: " ${(nowPopular[0].percent).round().toString()}%   ", style: TextStyle(color: Colors.redAccent[700], fontSize: 18)),
          TextSpan(text: getKeyFromValue(nowPopular[1].category), style: const TextStyle(fontSize: 18)),
          TextSpan(text: " ${(nowPopular[1].percent).round().toString()}%", style: TextStyle(color: Colors.redAccent[200], fontSize: 18))
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    data = context.watch<ArticleState>();
    return SingleChildScrollView(
      controller: controller,
      scrollDirection: Axis.vertical,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Block(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("경제 요약", style: bigHeading),
              const Line(),
              const SizedBox(height: 5),
              Text(
                widget.summaryText,
                style: const TextStyle(color: Colors.white, fontSize: 20, overflow: TextOverflow.ellipsis),
                softWrap: true,
                maxLines: null,
                overflow: TextOverflow.visible
              )
            ]
          )
        ),
        const SizedBox(height: 20),
        Block(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("지금 인기있는", style: bigHeading),
              const Line(),
              const SizedBox(height: 5),
              getPopularText()
            ],
          ),
        ),
        const SizedBox(height: 20),
        const ArticlePage(field: "주요")
      ])
    );
  }
}

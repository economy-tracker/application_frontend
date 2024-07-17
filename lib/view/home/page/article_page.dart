import 'package:application_frontend/view/home/provider/article_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core.dart';
import '../widget/line.dart';
import '../widget/article_list_view.dart';

class ArticlePage extends StatefulWidget {
  final String field;
  const ArticlePage({super.key, required this.field});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  int page = 0;
  late ArticleState data;
  late ScrollController controller;

  Future<void> loadData() async {
    if (controller.position.pixels > controller.position.maxScrollExtent-50){
      data.fetch(widget.field, page++);
    }
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(loadData);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      data = Provider.of<ArticleState>(context, listen: false);
      if (widget.field == "주요"){
        await data.fetchMain(page++);
      } else {
        await data.fetch(widget.field, page++);
      }
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
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${widget.field} 뉴스", style: heading),
          const Line(),
          const SizedBox(height: 20),
          ArticleListView(field: widget.field)
        ]
      )
    );
  }
}
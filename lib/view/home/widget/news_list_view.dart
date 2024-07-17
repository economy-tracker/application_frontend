import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core.dart';
import '../provider/news_list_provider.dart';
import 'news_widget.dart';

class NewsListView extends StatefulWidget {
  final String field;
  const NewsListView({super.key, required this.field});

  @override
  State<NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  late NewsState data;
  @override
  Widget build(BuildContext context) {
    data = context.watch<NewsState>();

    return Builder(
      builder: (context) {
        if(((widget.field == "주요") ? data.mainNews : data.fieldNews[widget.field]!).isEmpty){
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ((widget.field == "주요") ? data.mainNews : data.fieldNews[widget.field]!).length,
            itemBuilder: (context, index){
              return NewsWidget(data: ((widget.field == "주요") ? data.mainNews : data.fieldNews[widget.field]!)[index]);
            },
            shrinkWrap: true
          );
        }
      },
    );
  }
}

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
  late List<NewsData> value;
  @override
  Widget build(BuildContext context) {
    data = context.watch<NewsState>();
    if (widget.field == "메인"){
      value = data.mainNews;
    } else {
      value = data.fieldNews[widget.field]!;
    }
    return Builder(
      builder: (context) {
        if(value.isEmpty){
          return const Center(child: CircularProgressIndicator(),);
        } else {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: value.length,
            itemBuilder: (context, index){
              return NewsWidget(data: value[index]);
            },
            shrinkWrap: true
          );
        }
      },
    );
  }
}

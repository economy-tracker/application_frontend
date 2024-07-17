import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/article_list_provider.dart';
import 'article_widget.dart';

class ArticleListView extends StatefulWidget {
  final String field;
  const ArticleListView({super.key, required this.field});

  @override
  State<ArticleListView> createState() => _ArticleListViewState();
}

class _ArticleListViewState extends State<ArticleListView> {
  late ArticleState data;
  @override
  Widget build(BuildContext context) {
    data = context.watch<ArticleState>();

    return Builder(
      builder: (context) {
        if(widget.field == "주요" ? data.mainNews == null : data.fieldNews[widget.field] == null){
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ((widget.field == "주요") ? data.mainNews!.articles : data.fieldNews[widget.field]!.articles).length,
            itemBuilder: (context, index){
              return ArticleWidget(data: ((widget.field == "주요") ? data.mainNews!.articles : data.fieldNews[widget.field]!.articles)![index]);
            },
            shrinkWrap: true
          );
        }
      },
    );
  }
}
